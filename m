Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8B2571A5
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502937; cv=none; b=O8JyusjthXkOP34z14F8CTbxP1O6HpVgm8LRK1oiD94ZfBZrOzhlhEtRhMHX307ZwI6rpjbDY58p8uykcvd3T/fAMuRcXMYD6m13AkYkhH4NW3gmXFbRtTKVWttDiA2b/1HbxDfoAG4jX2cOjI48tDyPMcvYcJp4zHOkbN6YNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502937; c=relaxed/simple;
	bh=0HQ77LdRNnlNhPQKaWi0+fFU7Gijmj2y1aEGnVzzmUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+8ql4HrMWufjltD5swC/eYot9MAwreU4FvFsPraO/A4Ab8tfjfcWgcfb2Pg0HVOln41BkKos1riqtUASdRN7IbUWJ0d7lpbqSsLLnwYBBnStrpxFeTw6s3mnyFvh43MDPQMgoPTxwC53O9mjNCy2Z6fdSdZDHptCncZbIpjsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U9e52en3; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U9e52en3"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3df210930f7so17505685ab.1
        for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752502933; x=1753107733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OWi05X1JOxVzj2y8x/vxdLKOgX15Q9WfZ2Zm0wkXnCY=;
        b=U9e52en3nFVgce9SF8tc1V0V4VZ4vTrUGv5LsgMPG946f3v9wo6jVTxC1O1n8a8Rs8
         7s/ZaBBAVz99UEsAya/lZVsRde73Hq+S8vmYXOfnoEJjUMVFMRxOSZsHBblXHxFKNqh3
         9sFMf09p8so7UOLg3QdoRb14UAXYR1gvk4aUk4BcAX2lN24jWWZu5qvm1upnMB8O5yR6
         gLLFwnGIe4IfdnI3GSuHOK4w5VCHaijiB1UqqDb1Gs8j+tMmI7cFd2LI88nS8qX6JV9j
         ZBryQnn2KCQoWuDzUEIUoesykJuIAsoh3peCYI5l1pnYYr6lvylhapSLPECEhgf+Bz3w
         yWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752502933; x=1753107733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWi05X1JOxVzj2y8x/vxdLKOgX15Q9WfZ2Zm0wkXnCY=;
        b=NTU6WdpVZBiw8QeMUoXalDdvY6ZJ4ltxy/ghGumfcSoP6rkI+ouNsXdZtgBnPSWZt+
         ar7DUWXFdSvSXcXRqdYeTLFxWO91jUlNbhsEn7NFnNgpLWCW4rJ0SMLjCuiw2ClLgasd
         euyGZXyYbbFGjP6ldqUQQ8X31F6e1ZdtISRtHVp6Naqlz0o8aiSth0tdNoDsAPCsdGIE
         6OQp8FkBtC4YwXpme+s6lHLjfpLoweJ7dttI/KmnUlwrcQlaOge0O6cc3bFBHXkAXe28
         ebbbznWbf0gNDn7JjMuhrztexAd7byIx4OVhHCBjWobR+w0eyHP+TdvhHOOXdvqDk43f
         G8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc0un3MHrYqJ811Ybo2G5I7wbndpQyTmHIJDCevgOjsW3VIVxI/s6TLC1uXlsXak1o740oSFXiCPKqyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkrYWic0izXFonShmToKBaxaF8XP2NTPnsl+zpQaDATmnYG/Wo
	yxTTB8BgRmZOmKRKlo8mezdlLsAOk66rCE3vM/dEI+ZjbEs2N/ONAym9JtyXEhQ1Fa8=
X-Gm-Gg: ASbGncuwppdQV6UzsjJBtos/cdiXghXoWRHblYpwg6m/4AbGnvtih3VT4zbfOIB9Drg
	xBXDGgpIdkkQqximbIboltWDSR6JSI5ijrHBG4nsgYGOHTpJw9gDmKxxGMMnFy1DXx9pSgaUOwX
	2oc+EGuukWiEb07R1XIOa83ok301LcWJ/n0Y7XUbij7kOf1se1arp0EAtNHW/RM95zabk4tEj8z
	n8SUcfhzFxjK+MSfmVlmR1DQRAmrl1uZXvyXkZiiE2KSQHEqVhCr5BVEeeG/bmGQal5AMXKLuL3
	fy4WwOnjCYu8clinC0km1zq2aU37uJJRrUdXuPUoSnqGqVuUpfSOzjLtY3muK2uiBb/kO5t8z0N
	xcDPxtUZ1PTjLgqo9eRE=
X-Google-Smtp-Source: AGHT+IEX6hWLQtPd+BFrv53++vduZ3F8Mjg6zNJVMSXtw53CFyHFeYWki6RypUmrb8oKiZfANHiaag==
X-Received: by 2002:a05:6e02:dc4:b0:3d9:2992:671b with SMTP id e9e14a558f8ab-3e244642b0bmr120890725ab.4.1752502932840;
        Mon, 14 Jul 2025 07:22:12 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556532a2fsm2118885173.19.2025.07.14.07.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:22:12 -0700 (PDT)
Message-ID: <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
Date: Mon, 14 Jul 2025 08:22:11 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
To: Phillip Potter <phil@philpotter.co.uk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@gmail.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aHF4GRvXhM6TnROz@equinox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 2:46 PM, Phillip Potter wrote:
>> <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
>> <1>[335443.339262] #PF: supervisor read access in kernel mode
>> <1>[335443.339268] #PF: error_code(0x0000) - not-present page
>> <6>[335443.339273] PGD 0 P4D 0
>> <4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
>> <4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
>> <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
>> <4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
>> <4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
>> <4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
>> <4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> <4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
>> <4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
>> <4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
>> <4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
>> <4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> <4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
>> <4>[335443.339367] Call Trace:
>> <4>[335443.339372] <TASK>
>> <4>[335443.339379] ? __die_body+0xae/0xb0
>> <4>[335443.339389] ? page_fault_oops+0x381/0x3e0
>> <4>[335443.339398] ? exc_page_fault+0x4f/0xa0
>> <4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
>> <4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
>> <4>[335443.339432] ? blk_queue_enter+0x5a/0x250
>> <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
>> <4>[335443.339450] scsi_execute_cmd+0x65/0x240
>> <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
>> <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
>> <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
>> <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
>> <4>[335443.339506] disk_release+0xc8/0xe0
>> <4>[335443.339515] device_release+0x39/0x90
>> <4>[335443.339523] kobject_release+0x49/0xb0
>> <4>[335443.339533] bdev_release+0x19/0x30
>> <4>[335443.339540] deactivate_locked_super+0x3b/0x100
>> <4>[335443.339548] cleanup_mnt+0xaa/0x160
>> <4>[335443.339557] task_work_run+0x6c/0xb0
>> <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
>> <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
>> <4>[335443.339577] do_syscall_64+0x7e/0xa0
>> <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
>> <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
>> <4>[335443.339595] RIP: 0033:0x7d52bea41f07

This just looks totally broken, the cdrom layer trying to issue block
layer commands at exit time. Perhaps something like the below (utterly
untested) patch would be an improvement. Also gets rid of the silly
->exit() hook which exists just for mrw.


diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 21a10552da61..31ba1f8c1f78 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -624,9 +624,6 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
 	if (check_media_type == 1)
 		cdi->options |= (int) CDO_CHECK_TYPE;
 
-	if (CDROM_CAN(CDC_MRW_W))
-		cdi->exit = cdrom_mrw_exit;
-
 	if (cdi->ops->read_cdda_bpc)
 		cdi->cdda_method = CDDA_BPC_FULL;
 	else
@@ -651,9 +648,6 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 	list_del(&cdi->list);
 	mutex_unlock(&cdrom_mutex);
 
-	if (cdi->exit)
-		cdi->exit(cdi);
-
 	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
 }
 EXPORT_SYMBOL(unregister_cdrom);
@@ -1264,6 +1258,8 @@ void cdrom_release(struct cdrom_device_info *cdi)
 		cd_dbg(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n",
 		       cdi->name);
 		cdrom_dvd_rw_close_write(cdi);
+		if (CDROM_CAN(CDC_MRW_W))
+			cdrom_mrw_exit(cdi);
 
 		if ((cdo->capability & CDC_LOCK) && !cdi->keeplocked) {
 			cd_dbg(CD_CLOSE, "Unlocking door!\n");
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index fdfb61ccf55a..b907e6c2307d 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -62,7 +62,6 @@ struct cdrom_device_info {
 	__u8 last_sense;
 	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
 	unsigned short mmc3_profile;	/* current MMC3 profile */
-	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
 	bool opened_for_data;
 	__s64 last_media_change_ms;

-- 
Jens Axboe
