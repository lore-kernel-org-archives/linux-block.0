Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524381C2444
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 19:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728674198; cv=none; b=VJ5LAn7I4MqTjtwBfJLFyl6PazRYS6WPZqSBfI6O6PX9MkBVegbhCQ5KDqm+7hnoK/7hIByf4vYTmU7sxp0oOjir1dhh6mjGQsfic2CQ8DPpRC6C/FbqnIxCxlaHf+skX0GnvarWGTFiCbgPMKwMDPzJatcphgpicjxiVLTS++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728674198; c=relaxed/simple;
	bh=rP9cPu/oOztn/WQITtMS9fqM05qZ6hsvtaFoR4OoOWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPysJzO0+myL1CzQ52NCPzigLhyfrpLZMksZfhoKgPw0SEIH69hcHdTMdMIPlSY3jqUKeGk6jazar3rPQfz1VOiPA+pydZrHlUmWFoE6ji9B2OmseiVvTDQVZMNVWqDSZFT9jPAct/r2Lqj99oGUAQOiQpGzcgaT+/U4euVLXSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aCFVtVYh; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aCFVtVYh"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82cd93a6617so83328939f.3
        for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 12:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728674195; x=1729278995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyqOvaZH0m4jFFnShhbbodjqaw8lvoeGo8+pexKDSA8=;
        b=aCFVtVYhvfRQDF6bYovarqtjk4EQXTgfNVaA0jMm9lrpIjgu2lno0xyOBkRs6DtPlo
         uIB4hKBOTapcHhvw2bAu1e3VhnPeldkQ2kVbWQotfSuRBHFNnwY3rfAyEArhlVUOThQ3
         hu3b/vmMIHXQwAH6EcGam+XMUJyyvOTRfivyxvvyDrH7H/C+3Ww9Kdk6A9fse5zRpLdX
         H06GXwYuoIzh3QxzEx2sdSmPGVKbu6q4z3sblhQViB5xrKw6poUTlerpYDH/+prJb9ay
         LbEs8Zf10zs+XF7CyCKjDrnTEY7QHh71zceFhLJOBcZYfccEOsxp+CC/SCUEL6L86gE0
         i1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728674195; x=1729278995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyqOvaZH0m4jFFnShhbbodjqaw8lvoeGo8+pexKDSA8=;
        b=lUsRSXieDFcB8eVHGRMmahD8pTlLRM7RssTHqE99ZECvSzA5Dz1udoBiw4nF2LL6EY
         H1mV0wHgfUixosO3aRRyr7IQ6SeBMT79RA4dfUgtIvEM1AA+H8SSQHoZZXUvVyNxcpFj
         40emzNMthfaxmSx4KQAkRw12LZe9Q5lJhIFCthWXGYyxzukr9EoBnycM+yeUaXo/zGkb
         vOA9Onb6p0/zJMsOsSk1zShj37RRaBAhmBb/gGPw0S/LubqLG1l7r8/dqFFGsq1gD7o1
         6PIhiS13mTtZGYW1LFyzZfoMwp/xZRqGkA8sLbxEysxBfzsh1b9Ic1m8YakgUnJdRtYQ
         9oLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7SDhumMEF0aZIEm3qY5jQ81jcfGUjwaw/DvJ0as48ItaTACfHJGRqQtekBPrKd4LrmSA7kOTKhx//Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJd0Wcf5OAxJJKcVxtl3k2B328EA/lyPdkRN+pzbMkV1qZaGTm
	kqlvlw2RXDfaric0vCXLMNNLJr81M6gzH7yqh09PU6cjkmuNwDod5q+MBzBMwDI=
X-Google-Smtp-Source: AGHT+IGoHEMO/yD4yiGq9C78SGQjodBYNaaAnmYLZbcD9FMr222XQOM1sg3pV5sxxvJ2d3jPtQ6baQ==
X-Received: by 2002:a05:6e02:13a8:b0:3a0:a385:911d with SMTP id e9e14a558f8ab-3a3b5c71f26mr33007445ab.0.1728674195021;
        Fri, 11 Oct 2024 12:16:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdbcd2csm8323775ab.47.2024.10.11.12.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:16:34 -0700 (PDT)
Message-ID: <9f2b6f35-e923-4bf7-96cf-e4774e41ebb3@kernel.dk>
Date: Fri, 11 Oct 2024 13:16:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly trace report (Oct 2024)
To: Steven Rostedt <rostedt@goodmis.org>,
 syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, syzkaller-bugs@googlegroups.com,
 linux-block@vger.kernel.org, bpf@vger.kernel.org
References: <67094369.050a0220.4cbc0.000d.GAE@google.com>
 <20241011120028.1e4ed71c@gandalf.local.home>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241011120028.1e4ed71c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 10:00 AM, Steven Rostedt wrote:
> On Fri, 11 Oct 2024 08:25:29 -0700
> syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com> wrote:
> 
>> Hello trace maintainers/developers,
>>
>> This is a 31-day syzbot report for the trace subsystem.
>> All related reports/information can be found at:
>> https://syzkaller.appspot.com/upstream/s/trace
>>
>> During the period, 1 new issues were detected and 0 were fixed.
>> In total, 10 issues are still open and 38 have been fixed so far.
>>
>> Some of the still happening issues:
>>
>> Ref Crashes Repro Title
>> <1> 34      Yes   INFO: task hung in blk_trace_ioctl (4)
>>                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
> 
> If you check the maintainers file, blktrace.c has:
> 
> BLOCK LAYER
> M:      Jens Axboe <axboe@kernel.dk>
> L:      linux-block@vger.kernel.org

If syzbot can test this one, that would be appreciated. Guess here is
that we're stuck faulting under the debugfs_mutex. I took a look at the
syzbot reproducer, and no not going to attempt to run that... I strongly
suspect that the interesting bits there are:

1) Memory pressure/swap
2) blktrace setup/teardown, obviously

I do wish that once syzbot had a reproducer, it would continue
condensing it down into the most basic reproducer. Once you get into
"let's setup wifi, bluetooth, and tons of other things!" they become
almost impossible to run. And like in this case, I highly doubt they are
either related or useful.


diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8fd292d34d89..cefcad120495 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -617,8 +617,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return ret;
 }
 
-static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-			     struct block_device *bdev, char __user *arg)
+int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+		    struct block_device *bdev, char __user *arg)
 {
 	struct blk_user_trace_setup buts;
 	int ret;
@@ -627,28 +627,18 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (ret)
 		return -EFAULT;
 
+	mutex_lock(&q->debugfs_mutex);
 	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	mutex_unlock(&q->debugfs_mutex);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &buts, sizeof(buts))) {
-		__blk_trace_remove(q);
+		blk_trace_remove(q);
 		return -EFAULT;
 	}
-	return 0;
-}
 
-int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		    struct block_device *bdev,
-		    char __user *arg)
-{
-	int ret;
-
-	mutex_lock(&q->debugfs_mutex);
-	ret = __blk_trace_setup(q, name, dev, bdev, arg);
-	mutex_unlock(&q->debugfs_mutex);
-
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
@@ -673,12 +663,14 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
 		.pid = cbuts.pid,
 	};
 
+	mutex_lock(&q->debugfs_mutex);
 	ret = do_blk_trace_setup(q, name, dev, bdev, &buts);
+	mutex_unlock(&q->debugfs_mutex);
 	if (ret)
 		return ret;
 
 	if (copy_to_user(arg, &buts.name, ARRAY_SIZE(buts.name))) {
-		__blk_trace_remove(q);
+		blk_trace_remove(q);
 		return -EFAULT;
 	}
 
@@ -732,12 +724,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	int ret, start = 0;
 	char b[BDEVNAME_SIZE];
 
-	mutex_lock(&q->debugfs_mutex);
-
 	switch (cmd) {
 	case BLKTRACESETUP:
 		snprintf(b, sizeof(b), "%pg", bdev);
-		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		ret = blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
@@ -749,17 +739,16 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		start = 1;
 		fallthrough;
 	case BLKTRACESTOP:
-		ret = __blk_trace_startstop(q, start);
+		ret = blk_trace_startstop(q, start);
 		break;
 	case BLKTRACETEARDOWN:
-		ret = __blk_trace_remove(q);
+		ret = blk_trace_remove(q);
 		break;
 	default:
 		ret = -ENOTTY;
 		break;
 	}
 
-	mutex_unlock(&q->debugfs_mutex);
 	return ret;
 }
 

-- 
Jens Axboe
