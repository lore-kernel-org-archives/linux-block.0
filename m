Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A224C433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58575651AE
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 21:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhCIVTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhCIVSo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Mar 2021 16:18:44 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4299C06174A
        for <linux-block@vger.kernel.org>; Tue,  9 Mar 2021 13:18:43 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id e23so3881171wmh.3
        for <linux-block@vger.kernel.org>; Tue, 09 Mar 2021 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7puXEMns6yXED5Cipm23w3KOcm4gDxuggjUf51KLHTQ=;
        b=rGAqJWN9ilfYM1SO4qMWZvE+nNSI2R3JWDSKJRx3sysE+fH3oYybOnt8JLV6Ezqw1M
         B8jHfc+RhhSCAMgQxg5rXp/XTfM+fNJwhCwleKiIHT/0j+ljl3ZnwC33QNqW9RGwR60y
         ck2AaySaaA1/eRQffqYC328eC80Zm6hy84w9KhxjirzetfWccZv8DRoTo1JLZPuZb4WC
         Oe1ik7YkK0VMwKBzdH1BMC8cWGuA77Lenjyc4ZhTAUCXL0cXkcGEIJ570BAhCLbd7N1D
         GXQ1c/n1VifRYApW96OJM0v37tUv9rmaP/c/PKgwFlAbyw2Tud8GvIZUdPzoGGd461cv
         wPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7puXEMns6yXED5Cipm23w3KOcm4gDxuggjUf51KLHTQ=;
        b=fk5Fw1Gd5xJF2AJNLjyR8UQMN3EBEfvOvH1ghTX42ljt2X2saWu+uJvQJIHg43AqrE
         ja/aWnaELicwPD0Lw00SIG8h/AfMRuEWmT1eZEcb7rXiVCXchD3IlHM/62jwY5fLq2Ye
         Eci9aU5bFein0w4dUY24BvM30oce83Lxxel0ibxjiQldfaHXvq449SUBD6Pj9//rqle7
         olyz36CS5flDiO4cKuZmx+TW7Q8Jd4V/GlaD0QjIPHAvBE9jF+//MD1p3HHDCqeaoPfw
         3TtV1MrAq0etGc/UD2TYyLyyPYmeYMpeYv983QWexugx3uF0qj+cedOugF5uQP20w2A8
         Yb0A==
X-Gm-Message-State: AOAM533I4eRvO4V5jE39NR+vSgqWol5HFGxgESeaSi/9IHIsJ6/hwAwH
        3jeKKzSidADLtLVB0oj4sLi3sA==
X-Google-Smtp-Source: ABdhPJzuqIW0djcZgigY2I6784lju5FS2TCbP5AKmg3fcGMn6h8S4K++dO5zXnoTPxnQIPOPqBQDRg==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr6141029wmh.5.1615324722703;
        Tue, 09 Mar 2021 13:18:42 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id p6sm25289599wru.2.2021.03.09.13.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:18:42 -0800 (PST)
Date:   Tue, 9 Mar 2021 22:18:41 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309211841.tl5pq75iihilil5o@mpHalley.localdomain>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
 <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
 <20210309113103.GA9233@lst.de>
 <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
 <20210309150531.GA15052@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309150531.GA15052@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.03.2021 16:05, Christoph Hellwig wrote:
>On Tue, Mar 09, 2021 at 01:42:23PM +0100, Javier González wrote:
>>> - nvme_cdev_fops implements file operations that directly on a nvme_ns,
>>>   so they are path specific
>>
>> This is correct.
>>
>>> - we allow opening them even for a hidden controller
>>
>> This is also correct.
>>
>>> - there does not seem to be a char device node for ns_head at all.
>>
>> Also correct.
>>
>> We tried to keep it simple in the first iteration. Am I understanding
>> that you see necessary to have per ns_head char devices?
>
>That would be my understanding of "multipath support" for this character
>device, yes.  Especially as hiding the individual char devices for the
>hidden controllers once they are initially exposed would be an ABI break.

Ok. Will look into it for the next iteration.
