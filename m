Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFC7C6DF;
	Fri, 31 May 2024 05:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717135105; cv=none; b=K2vpmcO5q/yCMOHKm+vkaO8L/8vsjMv1bQvO8p6IfahBo5NpdKrKWHTQxWpkq0cvVoXGCnOTVdjNxX9VY7iFGHALG8ClQTgjc9CQdwJ9HuMm8DalG1KXDMOVR4WJDofxy9oSl1EpfJibRkX4erLuK/EkeWucHfxECVibXvqDgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717135105; c=relaxed/simple;
	bh=n2/TZmAk6sSunf3/F4jHYjmw+WZV9tzn8IgaYHxoFx4=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=hNaKeG2IW67uOtFD2qM1PXsVYY/84XvoIoEZ+DgaIMU7GyJRaWyS3hUnHnuXww8uhrGFqLnAm2CsNbfFqFHIo8+kTspxK9Q9fYbrMQ4SoBAse9q6qLD7b5M1nNYDrdTwLlPFIU9D8wfO5DQ4iGQ79alo9crUpd2j46q5Xj1md00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=famille-lp.fr; spf=pass smtp.mailfrom=famille-lp.fr; dkim=pass (1024-bit key) header.d=famille-lp.fr header.i=@famille-lp.fr header.b=geJlaAt/; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=famille-lp.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=famille-lp.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=famille-lp.fr header.i=@famille-lp.fr header.b="geJlaAt/"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 2546CDF87B7;
	Fri, 31 May 2024 07:48:37 +0200 (CEST)
Received: from mail.famille-lp.fr (unknown [82.64.142.12])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 5FFB32003C6;
	Fri, 31 May 2024 07:48:24 +0200 (CEST)
Received: from [192.168.0.7] (unknown [10.0.0.1])
	by mail.famille-lp.fr (Postfix) with ESMTPSA id 34E29A0CFB;
	Fri, 31 May 2024 05:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=famille-lp.fr;
	s=local; t=1717134502;
	bh=n2/TZmAk6sSunf3/F4jHYjmw+WZV9tzn8IgaYHxoFx4=;
	h=Date:Subject:References:To:Cc:From:In-Reply-To;
	b=geJlaAt/LTYp6T9l1oUaFm5aW/OKdm87LgAjIe9eK5Lavb7X1+C0UMMs4OC6zzUWo
	 tRTTnGPjb/YTX8mU/2Fl2FGavzKY1nSGNq0oxaJcFc3ddyzfAnDNhiUje5mvVc9qvd
	 4J0cuAgUkxVki5ypg6uXI+bB8TxM2opYmhmk22mI=
Message-ID: <5d188452-fe93-48b3-9eb7-e0fbcb5e3648@famille-lp.fr>
Date: Fri, 31 May 2024 07:48:03 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [BUG REPORT][BLOCK/NBD] Error when accessing qcow2 image through NBD
References: <6d33a50a-eea5-4a40-8976-fd6beff191ad@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
 linux-kernel@vger.kernel.org
From: Michel LAFON-PUYO <michel@famille-lp.fr>
Content-Language: en-US
In-Reply-To: <6d33a50a-eea5-4a40-8976-fd6beff191ad@gmail.com>
X-Forwarded-Message-Id: <6d33a50a-eea5-4a40-8976-fd6beff191ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi!


When switching from version 6.8.x to version 6.9.x, I've noticed errors when mounting NBD device:

mount: /tmp/test: can't read superblock on /dev/nbd0.
        dmesg(1) may have more information after failed mount system call.

dmesg shows this kind of messages:

[    5.138056] mount: attempt to access beyond end of device
                nbd0: rw=4096, sector=2, nr_sectors = 2 limit=0
[    5.138062] EXT4-fs (nbd0): unable to read superblock
[    5.140097] nbd0: detected capacity change from 0 to 1024000

or

[  144.431247] blk_print_req_error: 61 callbacks suppressed
[  144.431250] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 4 prio class 0
[  144.431254] buffer_io_error: 66 callbacks suppressed
[  144.431255] Buffer I/O error on dev nbd0, logical block 0, async page read
[  144.431258] Buffer I/O error on dev nbd0, logical block 1, async page read
[  144.431259] Buffer I/O error on dev nbd0, logical block 2, async page read
[  144.431260] Buffer I/O error on dev nbd0, logical block 3, async page read
[  144.431273] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.431275] Buffer I/O error on dev nbd0, logical block 0, async page read
[  144.431278] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.431279] Buffer I/O error on dev nbd0, logical block 1, async page read
[  144.431282] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.431283] Buffer I/O error on dev nbd0, logical block 2, async page read
[  144.431286] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.431287] Buffer I/O error on dev nbd0, logical block 3, async page read
[  144.431289]  nbd0: unable to read partition table
[  144.435144] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.435154] Buffer I/O error on dev nbd0, logical block 0, async page read
[  144.435161] I/O error, dev nbd0, sector 2 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.435166] Buffer I/O error on dev nbd0, logical block 1, async page read
[  144.435170] I/O error, dev nbd0, sector 4 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.436007] I/O error, dev nbd0, sector 6 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.436023] I/O error, dev nbd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  144.436034]  nbd0: unable to read partition table
[  144.437036]  nbd0: unable to read partition table
[  144.438712]  nbd0: unable to read partition table

It can be reproduced on v6.10-rc1.

I've bisected the commits between v6.8 tag and v6.9 tag on vanilla master branch and found out that commit 242a49e5c8784e93a99e4dc4277b28a8ba85eac5 seems to introduce this regression. When reverting this commit, everything seems fine.

There is only one change in this commit in drivers/block/nbd.c.

-static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
+static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,

+static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
+               loff_t blksize)
+{
+       int error;
+
+       blk_mq_freeze_queue(nbd->disk->queue);
+       error = __nbd_set_size(nbd, bytesize, blksize);
+       blk_mq_unfreeze_queue(nbd->disk->queue);
+
+       return error;
+}
+

To reproduce the issue, you need qemu-img and qemu-nbd. Executing the following script (as root) triggers the issue. This is not systematic but running the script once or twice is generally sufficient to get an error.

qemu-img create -f qcow2 test.img 500M
qemu-nbd -c /dev/nbd0 test.img
mkfs.ext4 /dev/nbd0
qemu-nbd -d /dev/nbd0
mkdir /tmp/test

for i in {1..20} ; do
     qemu-nbd -c /dev/nbd0 test.img
     mount /dev/nbd0 /tmp/test
     umount /dev/nbd0
     qemu-nbd -d /dev/nbd0
     sleep 0.5
done

Output of the script is similar to:

/dev/nbd0 disconnected
/dev/nbd0 disconnected
/dev/nbd0 disconnected
/dev/nbd0 disconnected
/dev/nbd0 disconnected
/dev/nbd0 disconnected
/dev/nbd0 disconnected
mount: /tmp/test: can't read superblock on /dev/nbd0.
        dmesg(1) may have more information after failed mount system call.

Can you please have a look at this issue?
I can help at testing patches.

Thanks,

Michel


