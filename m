Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B1733E368;
	Fri, 23 Jan 2026 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180451; cv=none; b=G75i7q+7Hwv9UymgIy9sEyvZjUctWlaBa+NrszlgfV7aU+WCXObS06sDIic0NURjVcfnlRA9xRTdN91g8tEEDR1xQ0ivmJCK9w8R9T5tsya10xnshjRgj5RZaWlN4HSGvgNmhmhQFS9VHx8wFvHYQtOjOYt25IKymQbEBry8Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180451; c=relaxed/simple;
	bh=jG2l8hIYUIs13LzRPlg0EEs5BVPaSsVc3bpkrBgkr5w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qbfcUYImk3tzD6owYOD0zLdKvQc0y6OA/ScAjKNsy0OARKVqLJih/AcJHFG5muSERZDK7ZwLaxo+S+Uxj/LqU1Fxyr6tc+0i6psVtyE49w/YfjYBFwwqoWADDIfXgUwbgf2bNce3t+xU6Y9JTwX3DQfdakW4CVlyBzFq/SOjWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=YPnxpL8T; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="YPnxpL8T"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769180445; bh=jG2l8hIYUIs13LzRPlg0EEs5BVPaSsVc3bpkrBgkr5w=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=YPnxpL8T+ZRZwGpoDr+hO8cpS4ElhZSIHWCGzvCocOki+vlw03raTjLEZhc2FMfRq
	 OqKvx1Cbtfk5mBq5iK9egUVlKsekGL7vLoPKmh4YCBA4frAC5OVnfPEHG7ArjhPdex
	 8NmqRdyeUduYrGA6FXgVtT6G4STwOg/Li8mkorwW6wGtzHtVGNg1k5VoPy9/jt3Jpn
	 AHbjlCtToeretFB0kKqD2kqM9p1GUYkR0eP4vqTPIC3N459ks3BpAGzLa2vfj8g08J
	 QC0g1DZYmpoElbfsRCRbGE4N2gCOTDeXqX40II4OTGAg3ujFU/25vfqeixpzdJIQsz
	 vwtvK6aSBzMdGx0LuA+JNy/dAsEAl5f1xAVvvURTYyEE2e5hAv28s4kFx2s0hJhacv
	 /Dh/COyx5AODm4iaAhnVk9myXT/ljv2eaZuguVKiKvSicIMtdg2uYvnLMOlKIMObxA
	 ZEY2QHWWg+sD9TFzQszu4r/BGh69WBPLIwhhq0TR6UVDUbX5NToVBCxWUxQ8MvyoQK
	 hI0OIMYTbUwkIuG3Oh1kwa45HNsYJnqPZrRUJqJzfxkkvGoz/V+1aeYGmQ/6NAkH0t
	 Zyygorqif+N5eVCboodwvfLjDT4946AI0TtUak61ByP2LFEAds91QsvpZ50dX/tckN
	 smbH6O47NYv+Ez3QBvMU58tI=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: ublk: use tmpdir for scratch files and improve
 relative paths use
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aXOGrXo3AbXPHA-K@fedora>
Date: Fri, 23 Jan 2026 17:00:33 +0200
Cc: Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com>
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora> <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
 <aXOGrXo3AbXPHA-K@fedora>
To: Ming Lei <ming.lei@redhat.com>



> On 23 Jan 2026, at 16:33, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Fri, Jan 23, 2026 at 03:59:31PM +0200, Alexander Atanasov wrote:
>> On 23 Jan 2026, at 15:33, Ming Lei <ming.lei@redhat.com> wrote:
>>>=20
>>> On Fri, Jan 23, 2026 at 11:20:36AM +0000, Alexander Atanasov wrote:
>>>> Create a temp dir for temporary files and use it instead of
>>>> placing them inside source tree.
>>>=20
>>> Many temporary files are backing files of file storage target, so =
far
>>> the code requires O_DIRECT, or the size could be a bit big.
>>>=20
>>> In case of ramfs/tmpfs of temp dir, it may cause problem for tests.
>>>=20
>>=20
>> I am aware of O_DIRECT problem but you can export different TMPDIR =
that has working O_DIRECT.
>=20
> Can you share how to export TMPDIR capable of O_DIRECT?


+export TMPDIR=3D$(mktemp -d ${TMPDIR:-/tmp}/ublktest-dir.XXXXXX)

I made the tests to run in own TMPDIR. Which is under already set TMPDIR =
or
if TMPDIR is not set it is defaults to  /tmp.

export TMPDIR=3D/path/to/odirect/capable
Before running and tests will run in:
/path/to/odirect/capable/ublktest-dir.XXXXXX


>=20
>>=20
>> I use sshfs mount of the build to run the tests and that is a problem =
sshfs/fuse does not
>> do O_DIRECT too.
>>=20
>> I think test_generic_06.sh is the only one that fails due to =
this(thou I still have to investigate).
>>=20
>> If O_DIRECT is required by the tests it may be possible to go thru a =
RAM disk which does support it,
>> so it works eveerywhere
>>=20
>> Other option is to preserve working in source tree as it is now, and =
just add a variable to specify working directory -
>> UBLK_TMPDIR or something.
>>=20
>>=20
>> I get a lot of out of order io - between 0 and 10 on average on my =
test setup:
>> tools/testing/selftests/ublk/test_generic_01.sh=20
>> Attached 3 probes
>> io_out_of_order: exp 564688 actual 564648
>> io_out_of_order: exp 564648 actual 565584
>> io_out_of_order: exp 565584 actual 564688
>> io_out_of_order: exp 565592 actual 564688
>> io_out_of_order: exp 566328 actual 565592
>> io_out_of_order: exp 882256 actual 882248
>> io_out_of_order: exp 883032 actual 882912
>> io_out_of_order: exp 882912 actual 883040
>> io_out_of_order: exp 883040 actual 883032
>>=20
>>=20
>> generic_01 : [FAIL]
>>=20
>> All rq-s are there just reordered , AFAIK blk-mq does not guarantee =
that requests will be completed in order, what=E2=80=99s the idea to =
catch this and
>=20
> If there is just 0 ~ 10, it could be fine. But if all are reorderd,
> something must be wrong. One improvement could be check if there is =
too
> many reorder...
>=20
> Actually what I am trying to test is to make sure same order is =
observed
> from both ublk driver dispatch code path and ublk target io handling =
code
> path, because io_uring task work schedule uses llist, which may =
introduce io
> reorder.

There are for sure other places where a reordering can be introduced, so =
the code should be ready and expecting=20
It. (For my case see bellow) Is preserving the order required for some =
reason for ublk?

>=20
> However, that involves ublk kprobe/kfunc trace, which may not be =
stable,
> so I simply check the end-to-end IO order. Sometimes blk-mq IO =
queue/dispatch
> may re-order IO.
>=20
> I guess the following change may avoid the re-order, but batch IO case =
may
> not be covered:
>=20
> diff --git a/tools/testing/selftests/ublk/test_generic_01.sh =
b/tools/testing/selftests/ublk/test_generic_01.sh
> index 21a31cd5491a..5805da4c84c5 100755
> --- a/tools/testing/selftests/ublk/test_generic_01.sh
> +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> @@ -29,14 +29,8 @@ if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
>        exit "$UBLK_SKIP_CODE"
> fi
>=20
> -# run fio over this ublk disk
> -fio --name=3Dwrite_seq \
> -    --filename=3D/dev/ublkb"${dev_id}" \
> -    --ioengine=3Dlibaio --iodepth=3D16 \
> -    --rw=3Dwrite \
> -    --size=3D512M \
> -    --direct=3D1 \
> -    --bs=3D4k > /dev/null 2>&1
> +taskset -c 0 dd if=3D/dev/zero of=3D/dev/ublkb"${dev_id}" bs=3D1M =
count=3D256 oflag=3Ddirect > /dev/null 2>&1
> +
>=20
>=20
>> consider it an error? (Latest tree with batch io and batch io fixes =
on top of if that matters)
>=20
> Never observe generic_01 failure in my test VM and hardware.
>=20
> My kernel config is based on Fedora, maybe scheduler config option =
makes the difference.

Fedora 43 default config with some debugging options enabled, but no =
changes in schedulers.
Test VM storage is on a networked NAS over iSCSI - both boxes VM host =
and NAS have two NICs,
I get the errors when I load the network. So I believe the requests =
really complete out of=20
order due to the network in my case. All tests that have the bpftrace =
check fail on occasion.


Regards,
Alexander Atanasov



