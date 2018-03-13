Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:37768 "EHLO othala.uls.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751556AbeCMRoq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 13:44:46 -0400
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "pieterk@uls.co.za" <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
 <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
 <1520737695.8740.4.camel@wdc.com>
 <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
 <1520744455.8740.9.camel@wdc.com>
 <0d5c21c2-4fea-5870-e971-f90556fb4141@uls.co.za>
 <1520950225.2921.0.camel@wdc.com>
 <cca75546-a02e-bed3-fda0-0003ccc5d158@uls.co.za>
 <1520953606.2638.5.camel@wdc.com>
 <b9f2421d-6350-1136-86ea-bdb70a59b6d9@uls.co.za>
 <1520961846.2638.25.camel@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <4197268e-5a9a-49a7-b2f3-db7b6e05e781@uls.co.za>
Date: Tue, 13 Mar 2018 19:44:40 +0200
MIME-Version: 1.0
In-Reply-To: <1520961846.2638.25.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On 13/03/2018 19:24, Bart Van Assche wrote:
> On Tue, 2018-03-13 at 19:16 +0200, Jaco Kroon wrote:
>> The server in question is the destination of  numerous rsync/ssh cases
>> (used primarily for backups) and is not intended as a real-time system.
>> I'm happy to enable the options below that you would indicate would be
>> helpful in pinpointing the problem (assuming we're not looking at a 8x
>> more CPU required type of degrading as I've recently seen with asterisk
>> lock debugging enabled). I've marked in bold below what I assume would
>> be helpful.  If you don't mind confirming for me I'll enable and
>> schedule a reboot.
> Hello Jaco,
>
> My recommendation is to wait until the mpt3sas maintainers post a fix
> for what I reported yesterday on the linux-scsi mailing list. Enabling
> CONFIG_DEBUG_ATOMIC_SLEEP has namely a very annoying consequence for the
> mpt3sas driver: the first process that hits the "sleep in atomic context"
> bug gets killed. I don't think that you want this kind of behavior on a
> production setup.
>
Would you mind adding myself as CC to that thread please?

Kind Regards,
Jaco
