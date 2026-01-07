Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864333164D0
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788602; cv=none; b=WpGQPE5GKTAYC9qGW4bceTNJojuCe9nWI2z49BQx1TNCEU4Hap/cF2VXvsosTnmvUeJ7PnDGWkwSK3Pbuli+vze98djwBcmGYDolHPFZK1+eDWfkEMv4kCAGqLDu2WXct9fHWU7jNBxEL/PAlCshIAaaEMYlmHh32aEjOur8xVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788602; c=relaxed/simple;
	bh=wMfV4DLmov5We8ex8vSzzWzBFTiHt4q0yCuToQVoHwc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFjZ/0O4hTKXEpsAwkpbdiNy2LQ42Ibng6sUWp8gJOd365EaMnO22fVv8CRdlRnLrOEMtYWRBUsY397ynksfMiYuJ5yGwtD5IgkeO2BXMKxpMlfg53CTZMndYRSG77dTrhzdQDrqvFV7dqiviNbRaHTMFuKzlDVQsxCoZpU+jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESmsqT1t; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESmsqT1t"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-382fb2bb83dso7228661fa.1
        for <linux-block@vger.kernel.org>; Wed, 07 Jan 2026 04:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788599; x=1768393399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cpAmgGcR/Yz8Fc5Id4B+s0tq7OgiXK7JplsVqgBRMI=;
        b=ESmsqT1tbaNEI3Xi3v9w+/eIN9P/r1B0MIZwsJwWXHoRUiCG/fS6vYE8v0978kYVHI
         v5OTHTXC0G/eVng1Qn5MsVQoivk5uYPI+vh35Ik3k8KXylOpUx4iniObEO+31Xgr+gnb
         RnUopAeLmUUPb9rs9kDBhNTzIaztek0LTV36HQnED7SME/h+exhN5qa5bY+9xgTBBQ1z
         9EyBKgS665DzIPxX7vSAGxrRQMIdgcDpsfuaAxH7QfQX98UZOySlzejx7X5o/KapUH0k
         7YJaUIHY8V2lNCkxJidEnKyN8+Tita16FsYxhrrHGflDxIAsKxchzc7AIoguYiRIs/JN
         2knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788599; x=1768393399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cpAmgGcR/Yz8Fc5Id4B+s0tq7OgiXK7JplsVqgBRMI=;
        b=crUoV+JiKWukqNkFcK8WoRjrBA2CKNOOuVmbf1BYVmyhp3iQzfpSkdqbpbfIv9gY0t
         OrNVK2dRIEl4ZIfSreZYTvMH5VfhhpJEIFrzMQMawIufOAEnBPPW6O0Mnm+8nF7AHSy4
         765alYS8/K98f0eHkib4HjJOlCdEK5RHfmRwPG3UtzcK6b+vHymA1hhmh8cYI3R2yshJ
         yUPRexTTcb6Sbr+32NnIuoJX1FGv0YOLFMYlpXbmBJpj8z0QvRbPAM/j6NYzIn1F4dgJ
         JJiTZ2IhiDiLKe97UnYThybA7lcpldYnFF36l6QxhBzA5+LaxeJFQRnNmESza4oMT9sA
         bzJA==
X-Forwarded-Encrypted: i=1; AJvYcCUqATjAqMitJrm/Pm5VcUYt4CXyIpOfrbE2QISkKNQPHbRwFyXFL+syHbilr07Q+TZHF85dGCgQ88/1Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyds7g3Qv6THbHsMHdVNYmNt0QxRJHwiukAbW4cb200SMU+6nwP
	Zdpihw9D0nfvknmxWw4d9xTLajUADWA0f50RvnsyN7wfqj3GaVtdvMxi
X-Gm-Gg: AY/fxX7uAN+Ltt0+rCIVCxmLlNwEPJyW2o58mwcs8Nx+2GWVufMem9ab3i8zRqLoAYI
	wG+oK1649RQ8uzXiYHcQVUSEEo0JFPuysw4/K5goq9WjniD9O8hliF8TxOtTu1RQ2nZU5Ps4UQE
	5b7yYI9XgMAV3AA+BIQIicQiG86B2YB2sNTUJTPjjPtmJ0MnGKH0Vrorz8cewYRJ6+Wl/+Ayzn+
	69qM3n6v2jNLNAnUIxZfdloTbGfviiUjtTBnkBLtXUEBw1aiU0BiGxurXgVa2x5ihj4Nx0c3X/x
	x/BMePcbuCK5kUQqkIcUjb3mmCa7156/YYLWpR+rIlvCO1mOeIIfSDfAJ4bV+2aFcMXSfmzohAn
	ycxLhMvBebuunHXr1DWQ/je9hHGM0JyL0m5aC32KZAbAJrcGV7+4DUpAi74n+1nM=
X-Google-Smtp-Source: AGHT+IGlIrisT4dG6ePjDdICGlJq9XxGoZMsfTO24oeTRKP23j82CCHzliHm9ok9Jknny6FgemwAFA==
X-Received: by 2002:a2e:a7cf:0:b0:383:b3:77d8 with SMTP id 38308e7fff4ca-38300b37af9mr6741381fa.45.1767788597966;
        Wed, 07 Jan 2026 04:23:17 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38302bd92fbsm2759361fa.3.2026.01.07.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:23:17 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 7 Jan 2026 13:23:15 +0100
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>,
	Fengnan Chang <changfengnan@bytedance.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
Message-ID: <aV5QM_N3OHBh3Tvt@milan>
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>

On Tue, Jan 06, 2026 at 04:56:07PM +0100, Mikulas Patocka wrote:
> On the kernel 6.19-rc, I am experiencing 15-second boot stall in a
> virtual machine when probing a virtio-scsi disk:
> [    1.011641] SCSI subsystem initialized
> [    1.013972] virtio_scsi virtio6: 16/0/0 default/read/poll queues
> [    1.015983] scsi host0: Virtio SCSI HBA
> [    1.019578] ACPI: \_SB_.GSIA: Enabled at IRQ 16
> [    1.020225] ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
> [    1.020228] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
> [    1.020230] ahci 0000:00:1f.2: flags: 64bit ncq only
> [    1.024688] scsi host1: ahci
> [    1.025432] scsi host2: ahci
> [    1.025966] scsi host3: ahci
> [    1.026511] scsi host4: ahci
> [    1.028371] scsi host5: ahci
> [    1.028918] scsi host6: ahci
> [    1.029266] ata1: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23100 irq 16 lpm-pol 1
> [    1.029305] ata2: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23180 irq 16 lpm-pol 1
> [    1.029316] ata3: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23200 irq 16 lpm-pol 1
> [    1.029327] ata4: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23280 irq 16 lpm-pol 1
> [    1.029341] ata5: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23300 irq 16 lpm-pol 1
> [    1.029356] ata6: SATA max UDMA/133 abar m4096@0xfea23000 port 0xfea23380 irq 16 lpm-pol 1
> [    1.118111] scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK 2.5+ PQ: 0 ANSI: 5
> [    1.348916] ata1: SATA link down (SStatus 0 SControl 300)
> [    1.350713] ata2: SATA link down (SStatus 0 SControl 300)
> [    1.351025] ata6: SATA link down (SStatus 0 SControl 300)
> [    1.351160] ata5: SATA link down (SStatus 0 SControl 300)
> [    1.351326] ata3: SATA link down (SStatus 0 SControl 300)
> [    1.351536] ata4: SATA link down (SStatus 0 SControl 300)
> [    1.449153] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
> [   16.483477] sd 0:0:0:0: Power-on or device reset occurred
> [   16.483691] sd 0:0:0:0: [sda] 2097152 512-byte logical blocks: (1.07 GB/1.00 GiB)
> [   16.483762] sd 0:0:0:0: [sda] Write Protect is off
> [   16.483877] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [   16.569225] sd 0:0:0:0: [sda] Attached SCSI disk
> 
> I bisected it and it is caused by the commit 89e1fb7ceffd which
> introduces calls to synchronize_rcu_expedited.
> 
> This commit replaces synchronize_rcu_expedited and kfree with a call to 
> kfree_rcu_mightsleep, avoiding the 15-second delay.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 89e1fb7ceffd ("blk-mq: fix potential uaf for 'queue_hw_ctx'")
> 
> ---
>  block/blk-mq.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-2.6/block/blk-mq.c
> ===================================================================
> --- linux-2.6.orig/block/blk-mq.c	2026-01-06 16:45:11.000000000 +0100
> +++ linux-2.6/block/blk-mq.c	2026-01-06 16:48:00.000000000 +0100
> @@ -4553,8 +4553,7 @@ static void __blk_mq_realloc_hw_ctxs(str
>  		 * Make sure reading the old queue_hw_ctx from other
>  		 * context concurrently won't trigger uaf.
>  		 */
> -		synchronize_rcu_expedited();
> -		kfree(hctxs);
> +		kfree_rcu_mightsleep(hctxs);
>  		hctxs = new_hctxs;
>  	}
>  
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
