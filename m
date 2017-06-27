Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:54390 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdF0Bc0 (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Mon, 26 Jun 2017 21:32:26 -0400
Subject: Re: [PATCH blktests] loop/002: Regression testing for loop device
 flush
To: Omar Sandoval <osandov@osandov.com>
Cc: osandov@fb.com, hch@infradead.org, axboe@fb.com, hare@suse.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@suse.com
References: <20170608122812.24225-1-jnwang@suse.com>
 <20170626185806.GA6710@vader.dhcp.thefacebook.com>
From: James Wang <jnwang@suse.com>
Message-ID: <045d4777-ae52-cf59-bb99-c032eda292d4@suse.com>
Date: Tue, 27 Jun 2017 09:31:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170626185806.GA6710@vader.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 06/27/2017 02:58 AM, Omar Sandoval wrote:
> Hi, James, thanks for sending this in. Sorry for the delay, I've been
> out of the office for a couple of weeks. A few comments below.
>
> On Thu, Jun 08, 2017 at 08:28:12PM +0800, James Wang wrote:
>> Add a regression testing for loop device. when an unbound device
>> be close that take too long time. kernel will consume serveral orders
>> of magnitude more wall time than it does for a mounted device.
>>
>> Signed-off-by: James Wang <jnwang@suse.com>
>> ---
>>  tests/loop/002     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/loop/002.out |  2 ++
>>  2 files changed, 79 insertions(+)
>>
>> diff --git a/tests/loop/002 b/tests/loop/002
>> new file mode 100755
>> index 0000000..fd607d1
>> --- /dev/null
>> +++ b/tests/loop/002
>> @@ -0,0 +1,77 @@
>> +#!/bin/bash
>> +#
>> +# Test if close()ing a unbound loop device is too slow
>> +# Copyright (C) 2017 James Wang
>> +#
>> +# This program is free software: you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation, either version 3 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +
>> +DESCRIPTION="Test if close()ing a unbound loop device is too slow"
>> +
>> +QUICK=1
>> +
>> +function run_test() {
> For consistency with everything else in blktests, please don't use
> "function" when defining a function.
I will fix it.
>> +	TIMEFORMAT='%5R'
>> +	time {
>> +		for f in `ls /dev/loop[0-9]*|sort`; do dd if=$f of=/dev/null  bs=512 count=1 >/dev/null 2>&1; done
>> +	}
>> +}
>> +function clean_up() {
>> +	if lsmod | grep loop >/dev/null 2>&1; then
>> +		umount /dev/loop* >/dev/null 2>&1
>> +		losetup -D
>> +		sleep 5
>> +		
>> +		if ! rmmod loop;then
>> +			return 2;
>> +		fi
>> +	fi
>> +}
>> +
>> +function prepare() {
>> +	modprobe loop max_loop=64
> If loop is already loaded, this won't work, right?
Actually, I could use clean_up() first , but due to My testing machine
has a bug causes clean_up() very slow......
I use call clean_up() before prepare(), make sense?
>
>> +	dd if=/dev/zero of=${TMPDIR}/disk bs=512 count=200K >/dev/null 2>&1
>> +	for((i=0;i<4;i++))
>> +	do
>> +	        losetup -f ${TMPDIR}/disk;
>> +	done
>> +	mkfs.ext4 -F /dev/loop0 >/dev/null 2>&1
> Hm, so if I happened to have something I care about on /dev/loop0,
> running blktests will destroy it? This is a no-go.
Yes, but due to our insert loop module and create a fake-disk and bound
to loop0, so format loop0 should doesn't matter.

>> +	for((i=0;i<4;i++))
>> +	do
>> +	        mkdir -p t$i;
>> +	        mount /dev/loop$i t$i;
>> +	done
>> +
>> +}
>> +
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	prepare
>> +	SECONDS=0
>> +	run_test >/dev/null 2>&1
>> +	DURATION=${SECONDS}
> Nifty, I didn't know about $SECONDS.
SECONDS is a built-in variable in bash, it will automatic increase.
>
>> +
>> +	clean_up
>> +	if ! clean_up; then
>> +		echo "Test complete"
>> +		return 2
>> +	fi
>> +	echo "Test complete"
>> +	if [[ "${DURATION}" -gt 1 ]]; then
>> +		return 1
>> +	else
>> +		return 0
>> +	fi
> I'd really like a meaningful output if this test fails, so something
> like this instead of the if/else
>
> if [[ "${DURATION}" -gt 1 ]]; then
> 	echo "test took too long ($DURATION seconds)"
> fi
I will fix this.
>> +}
>> diff --git a/tests/loop/002.out b/tests/loop/002.out
>> new file mode 100644
>> index 0000000..5c34a37
>> --- /dev/null
>> +++ b/tests/loop/002.out
>> @@ -0,0 +1,2 @@
>> +Running loop/002
>> +Test complete
>> -- 
>> 2.12.3
>>
> Overall, is there an easier way to test this than setting up 64 loop
> devices at modprobe time? E.g., can you losetup -f and run it on a
> single loop device many times to measure the same issue?
Use many loop devices for get a enough long time to compare with 1 second.
if we only create 1 loop device, I afraid it can't be measured.
In this scenario, I could get the duration of unbound and bound loop
device takes.
OK, I could try your suggestion.

I will send patch later.

James
>
> Thanks again!
>
>

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
