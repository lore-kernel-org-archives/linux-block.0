Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC5C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 18:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiEWSex (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiEWSeh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 14:34:37 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722AF6CF69;
        Mon, 23 May 2022 11:12:30 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id q18so13802279pln.12;
        Mon, 23 May 2022 11:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YcM2V9lJrQoILVWR8hE1O3AxcExnhJbF35MwvFVRNF0=;
        b=HVcTY5h0SXw5cM3/Ek/o0D5DVjf/WsJlpNVHctMRLPp8t+zDxV01ifHwl3D7cQHWeR
         zPpMiQGWGXkPCIQsy9ukBrpPfwcl2quH0andP5ZFcqzOaOZD64NMyl1X3nlx3ykj60iH
         +2mfx5eUW3gRjuaW18Gv5x9Kghrbgf9EetwN4m9CYGg5ebw0ZQLDgE08a7sWv5L4Kyux
         aSsiJukb8UnAzzUaaV0cL96KzvORKdve6cPhbTPda6ChALkUDN4IFb+ViESD9+feri6u
         wEHOqAovvpmsnnucdxtXmYYre95Pmu3YGITH8Ke8rRMjTeFiig/FI8OQvWVgsQFB+Ath
         NzDA==
X-Gm-Message-State: AOAM532aeeTe0pdigX1wfrhBeL6O7hRa4JXauLVguew4Gvlg+Y9Z1QWC
        G4FCX5XjoQTZKNxnvXsy8HI=
X-Google-Smtp-Source: ABdhPJyM/CwxpvBVN9kqgJt3dUJYAsl5xQQzoLnJApp0k9u48+L0bdeBCHhzQQ+qLqqg/d0Knkk4fQ==
X-Received: by 2002:a17:90a:8807:b0:1df:78c7:c215 with SMTP id s7-20020a17090a880700b001df78c7c215mr247975pjn.234.1653329485047;
        Mon, 23 May 2022 11:11:25 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id x3-20020a654143000000b003c14af50610sm5025690pgp.40.2022.05.23.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:11:24 -0700 (PDT)
Date:   Mon, 23 May 2022 11:11:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
        damien.lemoal@opensource.wdc.com, hare@suse.de,
        Johannes.Thumshirn@wdc.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v5 6/7] null_blk: use zone_size_sects_shift for power of
 2 zoned devices
Message-ID: <20220523181122.3vjizmsx7a2mpf6z@garbanzo>
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161612eucas1p102a76ba431c934230309042521018915@eucas1p1.samsung.com>
 <20220523161601.58078-7-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523161601.58078-7-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 23, 2022 at 06:16:00PM +0200, Pankaj Raghav wrote:
> Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
> the zone_size_sects_shift variable and use it for power of 2 zoned
> devices.
> 
> This variable will be set to zero for non power of 2 zoned devices.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
