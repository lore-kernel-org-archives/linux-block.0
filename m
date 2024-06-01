Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E628EA;
	Sat,  1 Jun 2024 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717223541; cv=none; b=qBKttBY35cdIaU5S/CA4J5pmWrGCnydHqrqji7NwC+xitSqBV+xhYeTOpWqL4l6oYXeKF35OLbIbdozbPSwIugaaPk1USFrVYOprQlAtMF43NFd7ioTqndyC3GRqicIU8hDJM6J+s7iyX6TZXjPyh8w8tLXdsR3tL6z51KdA9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717223541; c=relaxed/simple;
	bh=sPpUWYqfJp5cwAeUS4VoZjs3sQm3X8bcKnRiemeWoQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezgjW7tcCAGYpp6LXYWVdrkMrEnqwotVkhcZbH8Hk0vOX3Xp6DzZo+s5kzXVBc0KdtWOeboo9c1y+PRrTvezTyLJuDD1YHwnr1WzgPVUGeG40DmvW1e/vp9mG0RF+jhNOmIvQgiq7UR27S5KJUm9NkV4Ac6NQLfz/Z3X10n6uE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=famille-lp.fr; spf=pass smtp.mailfrom=famille-lp.fr; dkim=pass (1024-bit key) header.d=famille-lp.fr header.i=@famille-lp.fr header.b=GWCSfDk6; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=famille-lp.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=famille-lp.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=famille-lp.fr header.i=@famille-lp.fr header.b="GWCSfDk6"
Received: from mail.famille-lp.fr (unknown [82.64.142.12])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id ED2EA20039E;
	Sat,  1 Jun 2024 08:32:03 +0200 (CEST)
Received: from [192.168.0.7] (unknown [10.0.0.1])
	by mail.famille-lp.fr (Postfix) with ESMTPSA id 8DECFA0B8B;
	Sat,  1 Jun 2024 06:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=famille-lp.fr;
	s=local; t=1717223523;
	bh=sPpUWYqfJp5cwAeUS4VoZjs3sQm3X8bcKnRiemeWoQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GWCSfDk6d+dxbFfi+RGWTxvUg8Xej3QIapl5PxBvDyYX+anLPYL85zA2IvDBRHs8L
	 /KPMAbetG/7WGqTVaWb23FSys58wEJRel01xQjPBKhIZSiCroSLY1Q+yq9JoLTP5+R
	 YKdmHwAHpxl40vmEq59JXoG1pt9cK1r65zE5qprs=
Message-ID: <ab3da084-e119-4370-b935-b9c183ab5810@famille-lp.fr>
Date: Sat, 1 Jun 2024 08:32:02 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG REPORT][BLOCK/NBD] Error when accessing qcow2 image through
 NBD
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 nbd@other.debian.org, linux-kernel@vger.kernel.org
References: <6d33a50a-eea5-4a40-8976-fd6beff191ad@gmail.com>
 <5d188452-fe93-48b3-9eb7-e0fbcb5e3648@famille-lp.fr>
 <CAEzrpqfg6V5Pc-CcMqgceRapUWfb-HjAkFU9TUSEAoBNXbToFA@mail.gmail.com>
Content-Language: fr
From: Michel LAFON-PUYO <michel@famille-lp.fr>
In-Reply-To: <CAEzrpqfg6V5Pc-CcMqgceRapUWfb-HjAkFU9TUSEAoBNXbToFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 31/05/2024 à 17:17, Josef Bacik a écrit :
> On Fri, May 31, 2024 at 1:48 AM Michel LAFON-PUYO <michel@famille-lp.fr> wrote:
>> Hi!
>>
>>
>> When switching from version 6.8.x to version 6.9.x, I've noticed errors when mounting NBD device:
>>
>> mount: /tmp/test: can't read superblock on /dev/nbd0.
>>          dmesg(1) may have more information after failed mount system call.
>>
>> dmesg shows this kind of messages:
>>
>> [    5.138056] mount: attempt to access beyond end of device
>>                  nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
>> [    5.138062] EXT4-fs (nbd0): unable to read superblock
>> [    5.140097] nbd0: detected capacity change from 0 to 1024000
>>
>> or
>>
>> [  144.431247] blk_print_req_error: 61 callbacks suppressed
>> [  144.431250] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 4 prio class 0
>> [  144.431254] buffer_io_error: 66 callbacks suppressed
>> [  144.431255] Buffer I/O error on dev nbd0, logical block 0, async page read
>> [  144.431258] Buffer I/O error on dev nbd0, logical block 1, async page read
>> [  144.431259] Buffer I/O error on dev nbd0, logical block 2, async page read
>> [  144.431260] Buffer I/O error on dev nbd0, logical block 3, async page read
>> [  144.431273] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.431275] Buffer I/O error on dev nbd0, logical block 0, async page read
>> [  144.431278] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.431279] Buffer I/O error on dev nbd0, logical block 1, async page read
>> [  144.431282] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.431283] Buffer I/O error on dev nbd0, logical block 2, async page read
>> [  144.431286] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.431287] Buffer I/O error on dev nbd0, logical block 3, async page read
>> [  144.431289]  nbd0: unable to read partition table
>> [  144.435144] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.435154] Buffer I/O error on dev nbd0, logical block 0, async page read
>> [  144.435161] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.435166] Buffer I/O error on dev nbd0, logical block 1, async page read
>> [  144.435170] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.436007] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.436023] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [  144.436034]  nbd0: unable to read partition table
>> [  144.437036]  nbd0: unable to read partition table
>> [  144.438712]  nbd0: unable to read partition table
>>
>> It can be reproduced on v6.10-rc1.
>>
>> I've bisected the commits between v6.8 tag and v6.9 tag on vanilla master branch and found out that commit 242a49e5c8784e93a99e4dc4277b28a8ba85eac5 seems to introduce this regression. When reverting this commit, everything seems fine.
>>
>> There is only one change in this commit in drivers/block/nbd.c.
>>
>> -static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>> +static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>>
>> +static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>> +               loff_t blksize)
>> +{
>> +       int error;
>> +
>> +       blk_mq_freeze_queue(nbd->disk->queue);
>> +       error = __nbd_set_size(nbd, bytesize, blksize);
>> +       blk_mq_unfreeze_queue(nbd->disk->queue);
>> +
>> +       return error;
>> +}
>> +
>>
>> To reproduce the issue, you need qemu-img and qemu-nbd. Executing the following script (as root) triggers the issue. This is not systematic but running the script once or twice is generally sufficient to get an error.
>>
>> qemu-img create -f qcow2 test.img 500M
>> qemu-nbd -c /dev/nbd0 test.img
>> mkfs.ext4 /dev/nbd0
>> qemu-nbd -d /dev/nbd0
>> mkdir /tmp/test
>>
>> for i in {1..20} ; do
>>       qemu-nbd -c /dev/nbd0 test.img
>>       mount /dev/nbd0 /tmp/test
>>       umount /dev/nbd0
>>       qemu-nbd -d /dev/nbd0
>>       sleep 0.5
>> done
>>
>> Output of the script is similar to:
>>
>> /dev/nbd0 disconnected
>> /dev/nbd0 disconnected
>> /dev/nbd0 disconnected
>> /dev/nbd0 disconnected
>> /dev/nbd0 disconnected
>> /dev/nbd0 disconnected
>> /dev/nbd0 disconnected
>> mount: /tmp/test: can't read superblock on /dev/nbd0.
>>          dmesg(1) may have more information after failed mount system call.
>>
>> Can you please have a look at this issue?
>> I can help at testing patches.
>>
> This is just you racing with the connection being ready and the device
> being ready and you trying to mount it.  The timing has changed, if
> you look at this patch that I added for blk-tests you'll see the sort
> of thing that needs to be done
>
> https://github.com/osandov/blktests/commit/698f1a024cb4d69b4b6cd5500b72efa758340d05
>
> A better option for you is to load the module with devices=0, and use
> the netlink thing so that the device doesn't show up until it's
> actually connected.  This problem exists because historically we used
> the device itself to get configured, instead of a control device that
> would then add the device once it is ready.  We can't change the old
> way, but going forward to avoid this style of problem you'll want to
> use nbds_max=0 and then use the netlink interface for configuration,
> that'll give you a much more "normal" experience.  Thanks,
>
> Josef

Hi Josef,

I worked around the issue as you did in blk-tests. Thanks a lot for your support.

Michel

