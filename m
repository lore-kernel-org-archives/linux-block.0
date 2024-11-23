Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8AD259C
	for <linux-block@vger.kernel.org>; Sat, 23 Nov 2024 03:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732331297; cv=none; b=n4M+PwHfM02k8bpkyewO4IR1e8luIG1bYrjkvXMRoZNdnBdAFNd4u9MJqccxoMCkPGNNjZxNHtV8uyezzf8LcRdOcgCgZJRSqElUfSIvYXkDZSCQhfFVuUKdNukoYyMEDUDciBsznftgWfrb6D9HaJhEVbgh1IDXEtmN990t5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732331297; c=relaxed/simple;
	bh=hkZtDt6yzOTwtWW8IAc+3dcBF5bh3863pToLmOE41xs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PjERySMmSz+oMFiOWTToNCipk9C+jFaTMsZ7rs75R8B1LTvSP2/rcdthM5eDkN39EAqIYG6GDRE+oEHqyRNWwPa/6Wj7BOxRUkYwH4N+xShzZ1A2sF3QwyGIJT9IpOrlr7MxWPEiGBvVur0R0YzD06wsbdMWEV2CS3/VE5z3P3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B89x9Y+a; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B89x9Y+a"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724f41d550cso95151b3a.2
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 19:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732331296; x=1732936096; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cINaeAUIIndFtLyl+6OmBI358O1SecC811GRHej7EQA=;
        b=B89x9Y+adGxrzm2ylh+GloftYJKdZm/0hqOZ55kGtMRz9UYBJOVKOLusBszO/h/zE5
         1y4dLVoQYEE1Q7Zjs6DcJWSL450GYEv8JBse0Lww1AACIpzcD75d6zoKNby7TwGtSuzT
         PKHIgpDuA5FyhbzJeSE7XhCVYo7sZD3anXLOoeIW9KciQ2vEAx/Q+NKszcayACD7pU2r
         +W/eSipQmBpaOa0qmS8a0CCwPjCmDrjk/fcyDWJs+Y70W684eCAhXX2Z10FMY37O7esN
         am2S/D/yDe2PJoC5dDU/qnnXF6kcAUunfhZmzpCHKBxO/qU950yJVIcTuwmi2PYjEOiG
         K+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732331296; x=1732936096;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cINaeAUIIndFtLyl+6OmBI358O1SecC811GRHej7EQA=;
        b=b1qkYekwb0Z5lxh/0x/SwsTHu6L5eGvl6Lacfa+gPn1ehYMGDHVxZggfHcIwKRCZAu
         QQGrgmvikVtx9Zr9OijPOeudVkwGVmSwaTMLvGiq99xBb89ItTL0XHA3bozoAcf502sG
         ER/8niw081Vd6WnV/6fnCloB8h9CBL9Mxr8oDvl8w0EjE8pM/5dxyXSwIbBwqckqECZs
         1akPj/+JLGI0fA+n+Tcty6K9rAGzDfL9uniyO8Jb0p/zU2d0E5f6duzhiVV3UJgwk0uN
         mTg3Dy6E44lHG7E+SE6+zxHvHlANCaCRGkQoxGmRNggXGTtQdafz9nNXA6MB1m+VArfH
         7lcw==
X-Gm-Message-State: AOJu0Yz6SRRus+9a3jNUsMKYkAUpdSVRTzpQ0YH3yt0rxiziXmuQe2Ax
	bLiqZN7oOA+KJaWMpXgIvFH3UCF7m9Z07SdzeWdKBkSmRWy039TaaeE5bw==
X-Gm-Gg: ASbGnctnefAQG5nPD9UIzqSYZCezLIBYYH58wSE/K0QcB6fWKa3UBOw3asVGHZgKbQz
	/AeQ72DPRhEF4w3uzvUqvebFLftoumietrV3AlVxpvseFzoZmnYAEwvbOVYDQwqwV15INS388Pt
	uJmTK943pWPEzMmgBb1DgZaX3atnTwsn0QCyl5l00rX5T7V25avLfshA6L1vF9mMoEkxMDrqDD6
	tH2p1xhO6ayC7YGdBo2dCGgnruUnlWsr67rrdDQmPiJqoQpGgNESS2BL+DPU15eMhkRqRelIZU3
	b1daiYoXMCUhLDW1w2nf0YA=
X-Google-Smtp-Source: AGHT+IG6v0BjRhKvxQcMFslQcjFJavFSQTQ9HqG17yXxnWFZ7b7tx1hBAcNeFmsbAJTqg667k4R4Ew==
X-Received: by 2002:aa7:88cb:0:b0:71e:6f63:f076 with SMTP id d2e1a72fcca58-724df3cbf03mr7859454b3a.5.1732331295644;
        Fri, 22 Nov 2024 19:08:15 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532dbesm2365791b3a.112.2024.11.22.19.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 19:08:15 -0800 (PST)
Message-ID: <33753e7a-d38c-4a5e-9a8e-c2e27000337c@gmail.com>
Date: Fri, 22 Nov 2024 19:08:13 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@gmail.com>
Subject: Zone write plugging and the queue full condition
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Damien,

If I run the following shell commands:

modprobe -r scsi_debug
modprobe scsi_debug delay=0 dev_size_mb=256 every_nth=2 max_queue=1 \
   opts=0x8000 sector_size=4096 zbc=host-managed zone_nr_conv=0 
zone_size_mb=4
while true; do
     bdev=$(cd 
/sys/bus/pseudo/drivers/scsi_debug/adapter*/host*/target*/*/block && 
echo *) 2>/dev/null
     if [ -e /dev/"${bdev}" ]; then break; fi
     sleep .1
done
dev=/dev/"${bdev}"
[ -b "${dev}" ]
fio --direct=1 --filename=$dev --iodepth=1 --ioengine=io_uring \
     --ioscheduler=none --gtod_reduce=1 --hipri=0 --name="$(basename 
"${dev}")" \
     --runtime=30 --rw=rw --time_based=1 --zonemode=zbd &
sleep 2
echo w > /proc/sysrq-trigger

then the following appears in the kernel log:

     sysrq: Show Blocked State
     task:(udev-worker)   state:D stack:0     pid:3121  tgid:3121 
ppid:2191   fl
ags:0x00000006
     Call Trace:
      <TASK>
      __schedule+0x3e8/0x1410
      schedule+0x27/0xf0
      blk_mq_freeze_queue_wait+0x6f/0xa0
      queue_attr_store+0x60/0xc0
      kernfs_fop_write_iter+0x13e/0x1f0
      vfs_write+0x25b/0x420
      ksys_write+0x65/0xe0
      do_syscall_64+0x82/0x160
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

Do you agree that the above indicates that blk_mq_freeze_queue_wait()
hangs? I think it is waiting for a q_usage_counter reference that is
held by a bio on a zwplug->bio_list.

Do you agree that the best way to solve this is to modify
blk_mq_submit_bio() by moving the blk_zone_plug_bio() call after the
blk_crypto_rq_get_keyslot() call and also to change the zwplug bio list
into a request list?

If you agree with the above, do you want to implement these changes or
do you perhaps prefer that I implement these changes myself?

Thanks,

Bart.
