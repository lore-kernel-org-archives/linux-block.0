Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43529C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0873D21841
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UJAJwbR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLRSui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:50:38 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:51636 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeLRSui (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:50:38 -0500
Received: by mail-it1-f181.google.com with SMTP id w18so5433979ite.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5n5eMJpLrHjjWH6IBrb/41tHY4sm4vMBtd27Hu8P474=;
        b=UJAJwbR3uz+zerXJ/95Ntpe+CqD7sY0OueFcjXr8f+rgVbnl2bi3AIogaCvlul2X7h
         YunLhsudaXaz9yoAvCGHcu0lrGG0YqTe7h5wNIVAEpOA5buaj/Tlejtkd+ve9WKlyq3s
         e1vRMl87vFSYNtMPoxaDFGvl8lv6RN3hefbcdjPRIrkIbqUSMWTrX7VxLCi+Q2exUFyQ
         kM6oM8i5B/jewW3isZMVbihOWVvi/WkjBEj665hFZPB3DA1LKCoP9Ii/ChJw8DN/EsGX
         +bTP/QubL6LvLMCxpGzTwNTBT5TRGcY8bQLEndzeqU1H3vhMCSlZ7CcdM71i2TiF1Rb0
         IO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5n5eMJpLrHjjWH6IBrb/41tHY4sm4vMBtd27Hu8P474=;
        b=CmHz1tVlaKGbPac+IwO99qMSeO6USoSNwJsk4/hN8RBpZiRChSwaphQ5BkbEEXyzXO
         0Yw8AV4VRwNOtv1QLw1CORlmvEEJLJ9MvYARGPOGC2a1i97IhYpbPcOYAxr2XNxjnMwi
         pEwPJzOgvDtPKZuPk0PMYGC0yn9RCgBu81JtifpyjjLXKVjbT6XrTfngsVRuWfG+qbE0
         TQG18aiyfm9WkZqAhVUvKsbu40Dboh9zS+ucfp0IOHFcyEWABwn9on5SlR+qv9XLkPKe
         Lc45TpObr5GcPUQRKX7F440Md+kg/A058hpYAy2SEl99zf3pe+Zq6LVwrDDYDWhBHLQR
         F1Rw==
X-Gm-Message-State: AA+aEWblCRRyrYi30s8IKiHQnnTqmuk6pm98cR8aS8wGDdEU4uxecS+b
        For01OPZnIuoqHvfvrFHU+zPvA==
X-Google-Smtp-Source: AFSGD/XtMYz4UqE3wb3dx6yxUnnqJtUop7/KE+bet9A5OeCW1DSdwNKJFNQ+l7c1TKO+c+FyvYqJ4g==
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr16887589jad.98.1545159036766;
        Tue, 18 Dec 2018 10:50:36 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id i21sm7498907ioo.59.2018.12.18.10.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:50:35 -0800 (PST)
Subject: Re: confusion about nr of pending I/O requests
To:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4db2cb0f-e500-44da-e85d-ed417b74dae5@kernel.dk>
Date:   Tue, 18 Dec 2018 11:50:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <E0E52FD0-1020-4F5B-9AC8-F48BDFE142C0@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 5:45 AM, Paolo Valente wrote:
> Hi Jens,
> sorry for the following silly question, but maybe you can solve very
> quickly a doubt for which I'd spend much more time investigating.
> 
> While doing some tests with scsi_debug, I've just seen that (at least)
> with direct I/O, the maximum number of pending I/O requests (at least
> in the I/O schedulers) is equal, unexpectedly, to the queue depth of
> the drive and not to
> /sys/block/<dev>/queue/nr_requests
> 
> For example, after:
> 
> sudo modprobe scsi_debug max_queue=4
> 
> and with fio executed as follows:
> 
> job: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=20
> 
> I get this periodic trace, where four insertions are followed by four
> completions, and so on, till the end of the I/O.  This trace is taken
> with none, but the result is the same with bfq.
> 
>              fio-20275 [001] d...  7560.655213:   8,48   I   R 281088 + 8 [fio]
>              fio-20275 [001] d...  7560.655288:   8,48   I   R 281096 + 8 [fio]
>              fio-20275 [001] d...  7560.655311:   8,48   I   R 281104 + 8 [fio]
>              fio-20275 [001] d...  7560.655331:   8,48   I   R 281112 + 8 [fio]
>           <idle>-0     [001] d.h.  7560.749868:   8,48   C   R 281088 + 8 [0]
>           <idle>-0     [001] dNh.  7560.749912:   8,48   C   R 281096 + 8 [0]
>           <idle>-0     [001] dNh.  7560.749928:   8,48   C   R 281104 + 8 [0]
>           <idle>-0     [001] dNh.  7560.749934:   8,48   C   R 281112 + 8 [0]
>              fio-20275 [001] d...  7560.750023:   8,48   I   R 281120 + 8 [fio]
>              fio-20275 [001] d...  7560.750196:   8,48   I   R 281128 + 8 [fio]
>              fio-20275 [001] d...  7560.750229:   8,48   I   R 281136 + 8 [fio]
>              fio-20275 [001] d...  7560.750250:   8,48   I   R 281144 + 8 [fio]
>           <idle>-0     [001] d.h.  7560.842510:   8,48   C   R 281120 + 8 [0]
>           <idle>-0     [001] dNh.  7560.842551:   8,48   C   R 281128 + 8 [0]
>           <idle>-0     [001] dNh.  7560.842556:   8,48   C   R 281136 + 8 [0]
>           <idle>-0     [001] dNh.  7560.842562:   8,48   C   R 281144 + 8 [0]
> 
> Shouldn't the total number of pending requests reach
> /sys/block/<dev>/queue/nr_requests ?
> 
> The latter is of course equal to 8.

With a scheduler, the depth is what the scheduler provides. You cannot
exceed the hardware queue depth in any situation. You just have 8
requests available for scheduling, with a max of 4 being inflight on
the device side.

If both were 4, for instance, then you would have nothing to schedule
with, as all of them could reside on the hardware side. That's why
the scheduler defaults to twice the hardware queue depth.

-- 
Jens Axboe

