Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBD2C11CA
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776980929; cv=none; b=XylGCsr+AVTuYT0uFpOMny1LQINDUC1I/W2iPeMX7w52A7cF/asxwkn7Z/uKnA3BN1DUNVJgn5dmFJuuqjrKC9J0pedvzkbWSKmZ8OR83uWH4dB9Gyh4AzXdKXNIidiczOVxkkSC/Vg9OKcZ425lH4EGqpgn0eK5CSb72CCS2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776980929; c=relaxed/simple;
	bh=fMOGa9Rwyv9lL5SYVtE8xPa1vf8LUh9hNa830GKZu8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUA7d+Zehkt6RMNdeeQMJwd46aKqIGRHnW/YX5AYuf3a16jZx4R8lXJjMzC5MPPJft+jtU4l8/0a96snB7X+k6X7GsWziXjpJZy8n93Mv4UBXvjkj4UC6F63kb11Wd0LiZxP6KKNh24bY5ryEKgBWLoYL/WAubjkg3TImJt6PVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wlwyAkt8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wlwyAkt8"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479ae363aaeso4092867b6e.1
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 14:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776980925; x=1777585725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Om4Gff6PHUsp0JmJxEZIBhz8X2FJjaFcTZ+MBwubTI=;
        b=wlwyAkt8hvG4jDVhL71PnXHVjQtzXetfF91iooyk6XaiQGai0CTSY1diYOTGSz3vhw
         Ag/Q4Pf+b5uwRbdpWEYtkCXe6dzJr4fc1ICUds5bcl15IBoT1ewJQxnEnreXDOgW8Hi1
         ziXk2Qk4ZmsvUFE/uj1WjpODChWRpBlfletVxI/uNlinf5qpi2whiUhhtKZFMbQ4ZCVj
         ZaNZecScLFnUqx1XFiPmB5FyeX205fYjq4mPIT7Pd1B0FXNxz7JNgeK3sB6JMCrHCkfI
         HcdeNLqLpefY5S8qlY2tTkDRymhsRzFtjihn0cELbi2cLJRGN6jzyhCViU1+rEEHUVBf
         pjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776980925; x=1777585725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Om4Gff6PHUsp0JmJxEZIBhz8X2FJjaFcTZ+MBwubTI=;
        b=rUi9vrK+Sehhm0UM2mFS9t0MZz+rHJIWsy5tQS6DLZo5w1tNFWmMJFnRrPf9BBqqsL
         SQb0wrpb/s/1D8xn6r7o3tCCjOefuF9vOXKL3EevMnK3Q3gxx2OeYDx8kPAUP5rrCVtu
         Uhfvbt1AJi9vckL6cchUMmAXio5heIyTQjN+87avORyhQ5sSXlnrksWq/67tZSeHplbp
         6Nu3WVu2s3FXQXO6vFpqyFSOl+xiIyll9usAjEYxcDIrcyWylO0yiQ2+lpSYtIFPf072
         t2nEGSeO8jhzBQkmtT+rRA/ZMktfe6VlG6Af/Z5gW0GA8e7RweaOkaiqhNgTyAHrNnrv
         XmRw==
X-Forwarded-Encrypted: i=1; AFNElJ9CvP7FsSAikPaK3SaqmHBhoMlOmrYo4uyyai2gTzjeB7f2B4bTW9cgNWmWqTTDfT/ixQK+FeMPmmgtSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMTEwlTZkISCKo4RtiyH20AwWd+vGLqF1ChxQsUBmIqHRLAOn
	u5hLAFcM05FMAT9f9VHPw/kD8UA6dqAhUJqkl+A90yVw+nswYdLOWBn5prDMngw4Y5c=
X-Gm-Gg: AeBDieu9HspoiuyzmvOtqNYpKDn4fmWizBeP0P9z1QH7WZRQMIxNPmpiX15O5OXtQOi
	f8mE8vMDeFMngcREU1eNF2/+fBYpeO1e6LX4zQOjvSrLYjvMUjwtCW7YePPy4C/m8tdM2gp3zjg
	hv4sGkrpsKZzmrdMN/eXBm6T7UdHTDi44I+VbHQhvyTz2dud59gqWB3Hgf7/m0FLMmqKTTk/Z4j
	M03lPj04tKkiIri1YJMoqb8+WtvFVAH5R1xQwiistStdrXEFWlughvcYTuZRntZDN5YAfxmPsqv
	+4PLEY75kHCNqC2cuKTFU9fH6MJm4sCjX85Nx/Vq1Z4Smv+WtqTG34BwzVP6p5GnebAXih6iHlL
	nf8NcHwTp5eQSqG8j7zkurwKy4K7IrbB5kmLmQmkRtA6qTNak1ifUwiJr8uii0NPH9h5x2pMEu9
	Wx0cDLCVhynC9VTeORoZYxkKhaGiQVZYLc09oUyFfX6IfIsk0iell7ofWkS3aEBiDp4KKGzRQXx
	gMaLVF4aB7slo/JzWxW
X-Received: by 2002:a54:4386:0:b0:479:e96e:65b6 with SMTP id 5614622812f47-479e96ea357mr6270800b6e.13.1776980925139;
        Thu, 23 Apr 2026 14:48:45 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff36814sm14527947b6e.7.2026.04.23.14.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 14:48:44 -0700 (PDT)
Message-ID: <331c739c-d0fd-4c53-bbd5-cbb18f5dfedb@kernel.dk>
Date: Thu, 23 Apr 2026 15:48:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RCU warning off ublk_buf_cleanup() -> mas_for_each()
To: Bernd Schubert <bernd@bsbernd.com>, Ming Lei <tom.leiming@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Liam R. Howlett" <liam.howlett@oracle.com>
References: <0349d72d-dff8-4f9f-b448-919fa5ae96da@kernel.dk>
 <053fa6e7-43f7-4c80-9996-7fe6d8c28e45@bsbernd.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <053fa6e7-43f7-4c80-9996-7fe6d8c28e45@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 3:45 PM, Bernd Schubert wrote:
> 
> 
> On 4/21/26 19:47, Jens Axboe wrote:
>> Hi Ming,
>>
>> Ran into the below running tests on the current tree:
>>
>> =============================
>> WARNING: suspicious RCU usage
>> 7.0.0+ #16 Tainted: G                 N 
>> -----------------------------
>> lib/maple_tree.c:759 suspicious rcu_dereference_check() usage!
>>
>> other info that might help us debug this:
>>
>>
>> rcu_scheduler_active = 2, debug_locks = 1
>> 1 lock held by iou-wrk-55535/55536:
>>  #0: ffff800085a451a0 (ublk_ctl_mutex){+.+.}-{4:4}, at: ublk_ctrl_del_dev+0xdc/0x2f8
>>
>> stack backtrace:
>> CPU: 4 UID: 0 PID: 55536 Comm: iou-wrk-55535 Tainted: G                 N  7.0.0+ #16 PREEMPT 
>> Tainted: [N]=TEST
>> Hardware name: linux,dummy-virt (DT)
>> Call trace:
>>  show_stack+0x1c/0x30 (C)
>>  dump_stack_lvl+0x68/0x90
>>  dump_stack+0x18/0x20
>>  lockdep_rcu_suspicious+0x170/0x200
>>  mas_walk+0x3f0/0x6a0
>>  mas_find+0x1b4/0x6b0
>>  ublk_buf_cleanup+0xe0/0x240
>>  ublk_cdev_rel+0x34/0x1b0
>>  device_release+0xa4/0x350
>>  kobject_put+0x138/0x250
>>  put_device+0x18/0x30
>>  ublk_put_device+0x18/0x28
>>  ublk_ctrl_del_dev+0x120/0x2f8
>>  ublk_ctrl_uring_cmd+0x598/0x29b8
>>  io_uring_cmd+0x1e0/0x468
>>  __io_issue_sqe+0xa4/0x748
>>  io_issue_sqe+0x80/0xf68
>>  io_wq_submit_work+0x26c/0xdc8
>>  io_worker_handle_work+0x334/0xf20
>>  io_wq_worker+0x278/0x9e8
>>  ret_from_fork+0x10/0x20
>> Buffer I/O error on dev ublkb0, logical block 0, async page read
>> Buffer I/O error on dev ublkb0, logical block 0, async page read
>>  ublkb0: unable to read partition table
>> Buffer I/O error on dev ublkb0, logical block 0, async page read
>> Buffer I/O error on dev ublkb0, logical block 0, async page read
>> Buffer I/O error on dev ublkb0, logical block 512, async page read
>> Buffer I/O error on dev ublkb0, logical block 512, async page read
>> Buffer I/O error on dev ublkb0, logical block 0, async page read
>> Buffer I/O error on dev ublkb0, logical block 512, async page read
>>
>> and I briefly looked at it, but then just gave up as a) the maple tree
>> documentation is not that detailed, and b) other in-tree users also just
>> call mas_for_each() without either a lock held or RCU read side locked.
>>
>> Adding Liam for shedding some light on this...
>>
> 
> Hmm, that is another one, I run into
> 
> Date:   Thu Apr 16 15:16:04 2026 +0200
> 
>     ublk: Add rcu_read_lock/unlock in ublk_buf_cleanup
>     
>     [  399.994025] =============================
>     [  399.994694] WARNING: suspicious RCU usage
>     [  399.995464] 7.0.0+ #52 Not tainted
>     [  399.996034] -----------------------------
>     [  399.996697] lib/maple_tree.c:780 suspicious rcu_dereference_check() usage!
>     [  399.997748]
>                    other info that might help us debug this:
>     
>     [  399.998961]
>                    rcu_scheduler_active = 2, debug_locks = 1
>     [  399.999957] 1 lock held by iou-wrk-1495/1509:
>     [  400.000596]  #0: ffffffffa05e4590 (ublk_ctl_mutex){+.+.}-{4:4}, at: ublk_ctrl_del_dev+0x3d/0x190 [ublk_drv]
>     [  400.001796]
>                    stack backtrace:
>     [  400.002492] CPU: 40 UID: 0 PID: 1509 Comm: iou-wrk-1495 Not tainted 7.0.0+ #52 PREEMPT
>     [  400.002496] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
>     [  400.002498] Call Trace:
>     [  400.002500]  <TASK>
>     [  400.002503]  dump_stack_lvl+0x54/0x70
>     [  400.002511]  lockdep_rcu_suspicious+0x119/0x160
>     [  400.002521]  mas_start+0xed/0x140
>     [  400.002531]  mas_find+0x1a6/0x270
>     [  400.002538]  ublk_cdev_rel+0xb8/0x320 [ublk_drv]
> 
> 
> And have in my pbuf branch
> 
> index eb9b5dd8122c..208f6b5ad892 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -5478,6 +5478,7 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
>         struct ublk_buf_range *range;
>         struct page *pages[32];
>  
> +       rcu_read_lock();
>         mas_for_each(&mas, range, ULONG_MAX) {
>                 unsigned long base = mas.index;
>                 unsigned long nr = mas.last - base + 1;
> @@ -5495,6 +5496,7 @@ static void ublk_buf_cleanup(struct ublk_device *ub)
>                 }
>                 kfree(range);
>         }
> +       rcu_read_unlock();
>         mtree_destroy(&ub->buf_tree);
>         ida_destroy(&ub->buf_ida);
>  }

Fixed in patches going to Linus tomorrow, see HEAD~3..HEAD~1 in this
branch:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=block-7.1

-- 
Jens Axboe

