Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA47C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EA3207E8
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 10:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="w0WxvLqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgFZKBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFZKBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 06:01:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBFCC08C5C1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 03:01:03 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so5249354edy.1
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2020 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUl1b6ZKOKu+8M/8iIs9MV6jOq39RM7yd/5UXrQhPBg=;
        b=w0WxvLqZGuf7NzsEdBXumLQ4Dq0bASQTtoSlE2yk+jztzvPZukgMaGjduN8Kzm/cET
         xYYHn80gxOlrs+uIRaJhaRa6D6waGxvec1mpxEMnKyxbCswaggT0JGYQLLcEvSNUTAvo
         j8Vxr2Tkuv5yqCNFgDx4vWaj5FcVl0yVq5ZIEdgiGYPHSz8UinpTzGX4HvMulT0QbaRT
         NMWveSYkx35tdCw6eRZPtF/JZy0qciGwWTBgaAbmeE0s0vXT6fSSxcXJTnT1SXEhvLpX
         LhhdvX2W+utTQ9W8+K6s1oEIp0KxH8tVPcA53GuW+6Tq8WrJcZauPXpGtLtNTVRLAENY
         P2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUl1b6ZKOKu+8M/8iIs9MV6jOq39RM7yd/5UXrQhPBg=;
        b=brkhSqDzFGhfP6TraK1O2wIQMN1StV2VSaC3HeUtJY/HAaTSZ275Jbfkyl7jaRx/n7
         Le6E4rOJGOOEur5nx1iD51rBEYWLyYP6YAuILkMw90PRv7BwaZIy22HBjCJY0ehVdyW0
         n8iXGP50u4EhJogkqe326ROsoUFVz3eYpvh4OBJkM/w2gXN6LFmlX+i53V4SzB1x/ow9
         reyP+lcW9CzIdPzgiEY8dtTCrJdKdXFoWJ9WJaOAOQgVp5xKxSQYt8EUC6/rtQj8hEXr
         i3CZfpFo9prM1kkYVzxTohrS32MENLQvJTxPaf/67UqPYec7bI/+eOfnW4IQdPHG1PZe
         ZPWw==
X-Gm-Message-State: AOAM531uV3YIjt0bu+UAw3Ebud+J9CXNRmoyECztqqGtBp/LfRRoFdSy
        nYbON5uLlxjAjQ8je91IvgsWSQ==
X-Google-Smtp-Source: ABdhPJyX6ZGJUOZGR+giWfiEzv594FPvMsFiqAPf1gxFoZ4PsqFMv1gWz5Lx85XAqx/Mk5z895sgGQ==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr2548655edq.43.1593165661688;
        Fri, 26 Jun 2020 03:01:01 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id w18sm1030748ejc.62.2020.06.26.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 03:01:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 12:01:00 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
Message-ID: <20200626100100.gxwdmww7h4kmfxsq@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
 <20200626091427.GC26616@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200626091427.GC26616@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 26.06.2020 11:14, Christoph Hellwig wrote:
>> + * Zone Attributes
>> + */
>> +enum blk_zone_attr {
>> +	BLK_ZONE_ATTR_ZFC	= 1 << 0,
>> +	BLK_ZONE_ATTR_FZR	= 1 << 1,
>> +	BLK_ZONE_ATTR_RZR	= 1 << 2,
>> +	BLK_ZONE_ATTR_ZDEV	= 1 << 7,
>> +};
>
>I have no ^$^$#$%#% idea what this is supposed to be.  If you add
>userspace ABIs you need to document them in detail.  Until I've seen
>that documentation I can't even comment if they make sense.

Understood. I'll add the ZAC/ZBC attributes and document this properly
on V2.
