Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49933C433DF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2663622CAF
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596831122;
	bh=7SccDJRcnJlGaczNgQGhmwPoNfJABWkI4TY5ta2VIjo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KFgeMyrQKsY4sBRB1sFfv9IyZnaDOcpNeJq3EO9ADzmdpVPv7gwIyLa0z53YNwniw
	 F6Ok1CipcedxCHOZEEah1rH/takG5RRFqNfUj8N0PI6M6UaDDxJnc2KipaYCApGZKr
	 m2/CoVvmeE6sdbAec27lGzrgotl36zXXHqg3Au3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGUMB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgHGUMB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 16:12:01 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBE2C061756
        for <linux-block@vger.kernel.org>; Fri,  7 Aug 2020 13:12:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v9so3474962ljk.6
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkIYoRLWBrMd2qKy9T6QTqGHxJXs4ojV9w6Sr9SIdls=;
        b=F3oALBgLBhkNeiPWw4Et15B0KG6WttPjhjHuoIEUEN8JYnquQvaV75fjubAdYmQZCx
         zG/8u4nwGW1hqaUqn4Hs7W3Xh3y98MhB0esgXH4Xdi8dZ86rI+tDbuvNPMngw+eELdLf
         HaS6/NT2YsluMT8b0KmM/ig9xv6DWWzbClDLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkIYoRLWBrMd2qKy9T6QTqGHxJXs4ojV9w6Sr9SIdls=;
        b=MEdIpJGjhSrhre3hdGyPRnWQDsCzjLoz2Oq2qI7JRvJZuvlR+4m7IFmMllbNQpWQLz
         lZ5KModUZaI9k9RtDh4UdjhIh4hJ3STp0KCm7BYitqKalON2uaTCqhA/GCCQFAHZYowk
         IRhZWo/NSoKv6W7k6e0DenSctsO55dXceCAX/bDN7QSHRWXlj95t86dOo9YJEPBnV03a
         5OPDq6ZM5bsGA/HlXy1hH0McyI6cNB8dU13yhX9K6m+R8633ZnsUMMjdMgBh0Gg0n7mk
         Opv0o5EtXVDduLB2kx450ks/wwcFtyZLIc619ZjhAJXrKXzTZn9m3DCqRu/fsGQQrWsW
         YKyw==
X-Gm-Message-State: AOAM532wl8MZOz8s6TGSw6W55POsU58rkPtFEys0JqezXzBFlEdTe5Hx
        wRTrppL/WjAP0C3jTzUOCL6JXQQknrx6TA==
X-Google-Smtp-Source: ABdhPJwrIigFvJ+NeWT1sfqCK0DVkjO9tt5GT+nz99aKt6gdYIeQ3RfOB/KvPzkcR3Lf9ztSDj67yQ==
X-Received: by 2002:a2e:8215:: with SMTP id w21mr6934865ljg.43.1596831117663;
        Fri, 07 Aug 2020 13:11:57 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 1sm4208457ljr.6.2020.08.07.13.11.55
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 13:11:55 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id t23so3488607ljc.3
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 13:11:55 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr6135959ljk.421.1596831114811;
 Fri, 07 Aug 2020 13:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160327.GA977@redhat.com>
In-Reply-To: <20200807160327.GA977@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 13:11:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
Message-ID: <CAHk-=wiC=g-0yZW6QrEXRH53bUVAwEFgYxd05qgOnDLJYdzzcA@mail.gmail.com>
Subject: Re: [git pull] device mapper changes for 5.9
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block <linux-block@vger.kernel.org>,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Dorminy <jdorminy@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 7, 2020 at 9:03 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> - DM crypt improvement to optionally avoid async processing via
>   workqueues for reads and/or writes -- via "no_read_workqueue" and
>   "no_write_workqueue" features.  This more direct IO processing
>   improves latency and throughput with faster storage.  Avoiding
>   workqueue IO submission for writes (DM_CRYPT_NO_WRITE_WORKQUEUE) is
>   a requirement for adding zoned block device support to DM crypt.

Is there a reason the async workqueue isn't removed entirely if it's not a win?

Or at least made to not be the default.

Now it seems to be just optionally disabled, which seems the wrong way
around to me.

I do not believe async crypto has ever worked or been worth it.
Off-loaded crypto in the IO path, yes. Async using a workqueue? Naah.

Or do I misunderstand?

               Linus
