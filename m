Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B44BECE58F
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18B520873
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 22:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="x6O/M5gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfJOWrf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:47:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39729 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfJOWrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 18:47:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so3694402pgn.6
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CwaFwQ2EZDkwnZ1oMSfepKPamjONpLIDnHXV+aBlKRQ=;
        b=x6O/M5gWuM3Rxl+OWNoSNPCIfVaqlSHMG4L8s2ZGLgFcxAVl1woBr22d225brAcxWy
         TR0SIHp6I4ltRjpT4p9J+s3YJA09YCSNYYJiq8vhRiayn3SKj/8sl+3CMhn+9tl/aoJO
         vC1IzDs5xpG6e5nqGc9NQ7nsmDsc+wbOeApNM6XSZ+OkRD4HFufXizg2XdGkSyvD8jEt
         AxBhMXGCNl6zJa5WeyeNhBBdggbCo3z7kwCSc/oBukZKnznohvcbdwzHeigP73UU4Og0
         nReyfYflSit1Gnjak0LBb87Fz+Bqa83F23BnPQ0mCZSKiv+oqCGNVDTCooFiJEezVS/+
         tTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CwaFwQ2EZDkwnZ1oMSfepKPamjONpLIDnHXV+aBlKRQ=;
        b=fYeQ+Z6zUWBz29X+OX13Sne5IG+v+MIhEtqzP2fzETt1Cm+mNMepTopSWZdGQfCHIT
         CvWFQp4Qicm0/cBCYOsFz9F91mH8i6971YqI0wYgUmJhqFWdrGYbHICo5yD3OsOO8Kkm
         gzqf/SL/CVpV3EOuP0DV/Cc+GHHS0rw1/vfNaOvwFlYch5KmwieJhaJ4rrR4MoNoq9pi
         gEGrSpor8zS2WwrXibqDqD2PWkUiU9TZPAtQKROvpWoYCEPdzToE4DX7UzFw37Ics4qk
         7IgKgAj4jQ5dEraSeK5oRyVOrwhVvB77Lan6g3+0hYei+VjcUFBh6hVFM/jTYiYp6k3W
         hbMw==
X-Gm-Message-State: APjAAAUQWe2AgDMK+fs0kpZYN00HTF68wrAbDAhnfs2LzXShlXVvo7Xm
        QgWlve2ejq0Cv/JeXQ6Tx4nKjQ==
X-Google-Smtp-Source: APXvYqzozZ025UvPI4mTU0oLfTheZojtnyEDGy/5CCLxeXId68aOakr2R4TR29LO197YGxdwCEIM6w==
X-Received: by 2002:aa7:955a:: with SMTP id w26mr42408534pfq.193.1571179653572;
        Tue, 15 Oct 2019 15:47:33 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id 127sm20413709pfy.56.2019.10.15.15.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 15:47:33 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:47:32 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/027: remove duplicate --group_reporting=1
Message-ID: <20191015224732.GA450903@vader>
References: <20190909165506.14716-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909165506.14716-1-yi.zhang@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 10, 2019 at 12:55:06AM +0800, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/block/027 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/block/027 b/tests/block/027
> index 0ff9e4c..e818bf7 100755
> --- a/tests/block/027
> +++ b/tests/block/027
> @@ -56,7 +56,7 @@ scsi_debug_stress_remove() {
>  	local num_jobs=4 runtime=12
>  	fio --rw=randread --size=128G --direct=1 --ioengine=libaio \
>  		--iodepth=2048 --numjobs=$num_jobs --bs=4k \
> -		--group_reporting=1 --group_reporting=1 --runtime=$runtime \
> +		--group_reporting=1 --runtime=$runtime \
>  		--loops=10000 --cgroup="blktests/${TEST_NAME}" \
>  		"${fio_jobs[@]}" > "$FULL" 2>&1 &
>  

Thanks, applied.
