Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A5C43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 19:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340D02176D
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 19:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDWKV1Io"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLPTsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:48:18 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38027 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLPTsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 14:48:18 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so576435wmc.3;
        Mon, 16 Dec 2019 11:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=gMs5W1B63XydDPv1tVZEyDdvd/VWBIUBICPv+r011Yo=;
        b=oDWKV1IoySg+nhCOWvkfbTQ21os1U6ZYFlQAmwQQNFdVsSggyfyO2YWarnIgoNfpQU
         ijwK7h5bZayF3Czku/FbgiXCXtAMATIl5HVTeElZ8R/2IJvklOOzxWaIMCxnKXdYUiVQ
         q8MVHSDvuv/EmNuoHQSyRedXPpbNyOHPVlmPtRGVwv/gxHCThFgej+lCuRzNIcPQgVIK
         zrHMCgRrwASTi6kg3j/lb/jZRldu409u152RyF3tvWFFSTBuqwUmUNDw0XoCtn7yCzh+
         liamY6Hppjo73pmXIfInCD0aogCKSmS/R7WfM8dKbMQunMXB3cSw4aJcTkr0BlLGNzKq
         L4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=gMs5W1B63XydDPv1tVZEyDdvd/VWBIUBICPv+r011Yo=;
        b=dew2dMKQ8F1PG1vdntzVQHEdJW9tlMijkTpIgYrkwRmf2fD4rGsrqizDeOZnBgQb0Y
         bDCIusiSzFbxaO77AvHQvxnmhqHre3J9NL/NqUg+T74r3jABaY3eJiZNjjtAZhSBhUSi
         BXmSeeJC6V9W7NTiiEDhWBAlGwDZvAFILQnSkWg2Xd7fYz0WNmj+uIgjkZyHLNNkjqKF
         /3W81jWF+6IeXeLFuuPDGB/HRMMJ3TwbTpKINH8Q4YHtnM/S7EYNXJBqxWc1uw2rZ3Ey
         RQqrMi60j90X4+4+Q8AX9v1BjlmMlpFIpTd9ehy5p7AxTEgqlk45lXzsjGwKZ3C+c5pJ
         5Hgg==
X-Gm-Message-State: APjAAAXrp2K1xBT2HAyKl0T++cnWVJ1v0sDEfpmKyBdfGHFmdMEPBxaO
        LO0ABJJ4uSsg80Sokh/nuvw=
X-Google-Smtp-Source: APXvYqwLhSBt4MHodunA12ZJ4ZkVWkxRKGvHezgwEV5gjv9/Oag3A1y057CeAUk+IRolbEUx7Az53A==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr766192wmg.92.1576525695695;
        Mon, 16 Dec 2019 11:48:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id c4sm459672wml.7.2019.12.16.11.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Dec 2019 11:48:15 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     jgross@suse.com
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com, roger.pau@citrix.com,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        pdurrant@amazon.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Mon, 16 Dec 2019 20:48:03 +0100
Message-Id: <20191216194803.6294-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <2ad62cc8-ae78-6087-f277-923dc076383a@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On on, 16 Dec 2019 17:23:44 +0100, Jürgen Groß wrote:

> On 16.12.19 17:15, SeongJae Park wrote:
> > On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> > 
> >> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> >>
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> > [...]
> >>> --- a/drivers/block/xen-blkback/xenbus.c
> >>> +++ b/drivers/block/xen-blkback/xenbus.c
> >>> @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
> >>>   }
> >>>   
> >>>   
> >>> +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> >>> +static unsigned int buffer_squeeze_duration_ms = 10;
> >>> +module_param_named(buffer_squeeze_duration_ms,
> >>> +		buffer_squeeze_duration_ms, int, 0644);
> >>> +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> >>> +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> >>> +
> >>> +/*
> >>> + * Callback received when the memory pressure is detected.
> >>> + */
> >>> +static void reclaim_memory(struct xenbus_device *dev)
> >>> +{
> >>> +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> >>> +
> >>> +	be->blkif->buffer_squeeze_end = jiffies +
> >>> +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> >>
> >> This callback might race with 'xen_blkbk_probe()'.  The race could result in
> >> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
> >> 'be' to the 'dev'.  Please _don't merge_ this patch now!
> >>
> >> I will do more test and share results.  Meanwhile, if you have any opinion,
> >> please let me know.

I reduced system memory and attached bunch of devices in short time so that
memory pressure occurs while device attachments are ongoing.  Under this
circumstance, I was able to see the race.

> > 
> > Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
> > concurrency issues could be in other drivers in their way, I suggest to change
> > the reclaim callback ('->reclaim_memory') to be called for each driver instead
> > of each device.  Then, each driver could be able to deal with its concurrency
> > issues by itself.
> 
> Hmm, I don't like that. This would need to be changed back in case we
> add per-guest quota.

Extending this callback in that way would be still not too hard.  We could use
the argument to the callback.  I would keep the argument of the callback to
'struct device *' as is, and will add a comment saying 'NULL' value of the
argument means every devices.  As an example, xenbus would pass NULL-ending
array of the device pointers that need to free its resources.

After seeing this race, I am now also thinking it could be better to delegate
detailed control of each device to its driver, as some drivers have some
complicated and unique relation with its devices.

> 
> Wouldn't a get_device() before calling the callback and a put_device()
> afterwards avoid that problem?

I didn't used the reference count manipulation operations because other similar
parts also didn't.  But, if there is no implicit reference count guarantee, it
seems those operations are indeed necessary.

That said, as get/put operations only adjust the reference count, those will
not make the callback to wait until the linking of the 'backend' and 'blkif' to
the device (xen_blkbk_probe()) is finished.  Thus, the race could still happen.
Or, am I missing something?

I also modified the code to do 'get_device()' and 'put_device()' as you
suggested and did test, but the race was still reproducible.


Thanks,
SeongJae Park

> 
> 
> Juergen
