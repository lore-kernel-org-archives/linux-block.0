Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D2C433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE844207F9
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591107459;
	bh=iLj9pYrq9V4LFWwAsEDzdAkmjozDNKU5Fg4Ni7PvwHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QqKMuyH0rNIWzOql+XG7Q7CyjciD9Ob1FW23N00iFX0JbSbgqZzPZRZT7lIW39bGF
	 fG7p7moM/s8sfuJe3WgKmVoCvAlqKA0bsi4MNv1LzHHpE10uTLy+mPizcly6EF0duG
	 CCwR5Wre9FTzRYoSAwGyzpsqtNKA9RY4YXNqYrCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgFBORj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:17:39 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:52695 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBORj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 10:17:39 -0400
Received: by mail-pj1-f50.google.com with SMTP id k2so1431410pjs.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2020 07:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QzKU27OAkrjSQuPEhW+8khPDASbGPxn01itV3ETlpOQ=;
        b=g8TsOgINXLajEROfdwdIcW5kaTWr++I1xm2B5YFgib1DTuGjmfsfgVXLgJf5QzkdaB
         MX1XnAiMrgN9hfVqFXuNhkWvD04TgpPZEFWho9z0p4vlj8U/FqdpkeXT+joKykiZUrrM
         1JluwV9zW8YfAeBUTfA6RdSkQ/n7SWXD94oWda+gb65wTj8VcBjO8OATXgfWRPhVRlEq
         VGYF7wHO19IJ0+H0lHbFm1POwEV8Nrlqr+HEXqeVxBaXL1svGYcXUdqtyjX9Twq4l9gm
         5Qc2pvkYX1Qv08d9HlaBdUB85kJ1iw43o7YivrT81NSjACwilh1YU05Ow9KKH5tjSK0d
         pruQ==
X-Gm-Message-State: AOAM532A2gM5lo2EFiEbIUnoAQysO055j09vXjQx+EU0vxqXYlheVEVJ
        auRbBjWIYSlmbCTk048tqZJR/OnR7To=
X-Google-Smtp-Source: ABdhPJw23rBZJN2sXej3OM2ebvLL0q6dzmkXByz4sJnc06YvGAHGNELTcqhST6bDfuYYrUwUT8HUrw==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr6086419pjn.126.1591107458048;
        Tue, 02 Jun 2020 07:17:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g21sm2290414pjl.3.2020.06.02.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:17:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C402340256; Tue,  2 Jun 2020 14:17:34 +0000 (UTC)
Date:   Tue, 2 Jun 2020 14:17:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, bvanassche@acm.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200602141734.GL11244@42.do-not-panic.com>
References: <20200602071205.22057-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602071205.22057-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 02, 2020 at 09:12:05AM +0200, Jan Kara wrote:
> Here is version of my patch rebased on top of Luis' blktrace fixes. Luis, if
> the patch looks fine, can you perhaps include it in your series since it seems
> you'll do another revision of your series due to discussion over patch 5/7?
> Thanks!

Sure thing, will throw in the pile.

  Luis
