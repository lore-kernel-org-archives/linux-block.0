Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57AD14A8B
	for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782767; cv=none; b=PyaQDvTFB38+SaLAshB2inY/D/EAq9zgVJ2omwfgWQnwNLy7kdq9zxpsuY3d+nK4XZWtmzH1GoEQi4Iak50H7vRQlyqTKw5iJLTRki/Be0DXLIlhJdaziGBAajdZP6qPjrq/bl47+ryhHIZ4GfxJRtWdEPyRQKBfZgbEt9o29cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782767; c=relaxed/simple;
	bh=kIAjzPhBsy5dVmAWTT9xmEBHAh3C00ouOaMeMjDyoOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQanSZzuGx415+bkZjd1UCP4L1XSAP6aQAZX8BaIGIFx214zN+yBDLCf43K+MLVWOCCFtcW8igzrib8oxhwGBob61M1bDYUJ3BNM1aRsmCUNmbqXUcUc1lpfkTGEWLk9yRCZLV2nZnB47oEaNe3iR9vlTcz02+1cNoqQ/w2qUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1166576f8f.0
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2024 03:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782764; x=1714387564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss5beKZTHht2vaLBTc6HYCogExwfAkEZk+V+c9HgkFw=;
        b=p9JGYkAaWbrH2HpArY+U2QqOLo2Ex+iFjY825vTtJApWnEUDEj/96XmkRMB3G77idl
         1fHllIkO75nT4HoTygcp5nrERYWVTyCjvRLtCNirI1Q5givyTC1ei+Vpyt2Q6pTvkvYu
         GEZcBEsOgO3THeE8E8juXCwWw/sWdISfhPakbzGWBi3wY47wz8kS8dz7yUNLfjQKHxDV
         A+pYTpIIqBys0znw+foy+wYd4qzVT3FAAPXxe5eMzNQ3yOCF6CHBY7aoo037zRkscTHb
         ewSs6wYHI+7rp051F9u/iFCWKJPcYXXt8rydUUYxvuNK9K1baJQmhFLol+IRs0C6b3bB
         k8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8HQJtjT8Fn6YVKYm0abJo83qqBvheXtv9aEAVxGN0LY4UBG+xeIt0LB6BqbNnAx8qkWGYb3c50FTOijA7YcTo4d1Vt5IxIf2yO2I=
X-Gm-Message-State: AOJu0YyYxtHE0hiwCxM69XBe4Ck5ZOFzSZP/29LNyZCRTeB38SxN/OWt
	ZS32oAy7DFsgxRSJ8dGerY2vkmqwAVkQt5UDWdfJoYp/AJoViSkYQKonow==
X-Google-Smtp-Source: AGHT+IHxzDoUkIFLa0ivqbj6YgwpYzzSYZkL37RYWvKY4Zi82lkd/iEbQi2NHw+Hq/vE/UNJMynxSw==
X-Received: by 2002:a05:600c:1d10:b0:418:3d9b:b38e with SMTP id l16-20020a05600c1d1000b004183d9bb38emr6638369wms.4.1713782763863;
        Mon, 22 Apr 2024 03:46:03 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c468600b0041563096e15sm20224057wmo.5.2024.04.22.03.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 03:46:03 -0700 (PDT)
Message-ID: <54666822-4e7f-4ec2-982b-541380cec154@grimberg.me>
Date: Mon, 22 Apr 2024 13:46:02 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
 <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
 <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs9UN_pV_raSL2+wNRP9yBeJWkx0_GtHSQ0QoC3jYxhfQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/04/2024 7:59, Yi Zhang wrote:
> On Sun, Apr 21, 2024 at 6:31 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>>
>>
>> On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
>>> +linux-nvme list for awareness ...
>>>
>>> -ck
>>>
>>>
>>> On 4/6/24 17:38, Yi Zhang wrote:
>>>> Hello
>>>>
>>>> I found the kmemleak issue after blktests nvme/tcp tests on the latest
>>>> linux-block/for-next, please help check it and let me know if you need
>>>> any info/testing for it, thanks.
>>> it will help others to specify which testcase you are using ...
>>>
>>>> # dmesg | grep kmemleak
>>>> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>>
>>>> # cat kmemleak.log
>>>> unreferenced object 0xffff8885a1abe740 (size 32):
>>>>      comm "kworker/40:1H", pid 799, jiffies 4296062986
>>>>      hex dump (first 32 bytes):
>>>>        c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.............
>>>>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>>      backtrace (crc 6328eade):
>>>>        [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>>>        [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
>>>>        [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
>>>>        [<ffffffffc26287ef>] 0xffffffffc26287ef
>>>>        [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>>>        [<ffffffffc262a881>] 0xffffffffc262a881
>>>>        [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>>>        [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>>>        [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>>>        [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>>>        [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>>>> unreferenced object 0xffff88a8b03647c0 (size 16):
>>>>      comm "kworker/40:1H", pid 799, jiffies 4296062986
>>>>      hex dump (first 16 bytes):
>>>>        c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.............
>>>>      backtrace (crc 860ce62b):
>>>>        [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>>>        [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
>>>>        [<ffffffffc26287ef>] 0xffffffffc26287ef
>>>>        [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>>>        [<ffffffffc262a881>] 0xffffffffc262a881
>>>>        [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>>>        [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>>>        [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>>>        [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>>>        [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>> kmemleak suggest that the leakage is coming from lo_read_simple() Is
>> this a regression that can be bisected?
>>
> It's not one regression issue, I tried 6.7 and it also can be reproduced.

Its strange that the stack makes it look like lo_read_simple is allocating
the sgl, it is probably nvmet-tcp though.

Can you try with the patch below:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a5422e2c979a..bfd1cf7cc1c2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,6 +348,7 @@ static int nvmet_tcp_check_ddgst(struct 
nvmet_tcp_queue *queue, void *pdu)
         return 0;
  }

+/* safe to call multiple times */
  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
  {
         kfree(cmd->iov);
@@ -1581,13 +1582,9 @@ static void 
nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
         struct nvmet_tcp_cmd *cmd = queue->cmds;
         int i;

-       for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-               if (nvmet_tcp_need_data_in(cmd))
-                       nvmet_tcp_free_cmd_buffers(cmd);
-       }
-
-       if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-               nvmet_tcp_free_cmd_buffers(&queue->connect);
+       for (i = 0; i < queue->nr_cmds; i++, cmd++)
+               nvmet_tcp_free_cmd_buffers(cmd);
+       nvmet_tcp_free_cmd_buffers(&queue->connect);
  }

  static void nvmet_tcp_release_queue_work(struct work_struct *w)
--
