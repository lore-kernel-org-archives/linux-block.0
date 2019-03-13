Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A847C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B322075C
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 19:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfCMTMR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:17 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33361 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbfCMTMO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:14 -0400
Received: by mail-ot1-f53.google.com with SMTP id q24so2825375otk.0
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 12:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/NLPpgu9/PmlluRh2nsFXMORQeNnpDeI4d57NUOjLc=;
        b=WRRfiNdbPk58FhibTu08431GrZ4/IuiFaFqWAlEvChuC0M4YYkAxIH12DipOTZvdn0
         CTuxzcgeNozHJDVgxYR19mgdCXwgHVB6F5uYhMR7syM7z3QoFlzad6mOu7wTp46TxrgS
         6bKC/4xG3tgp5vQDjUr9+zaaXG3EGb+BuKq8P5/FWb3p15ObjHU9n5j91uRGHYZlP2NU
         3GL5CwB2yUNbW2ya8nptQpG6TWutx86JiyJt4zlAlks27JjtlNPDxsS9VV8LBc0BS6qn
         UT8HBo4QZGnnSodzsF7ShnY3kh32461sCw/64gzfvH5YAcLv4jAdxJOj/GAGznZwZAtn
         x3aA==
X-Gm-Message-State: APjAAAUl/9MzINbHdMelik2ClkUNtptOI8H0q+KvIVl7Kq8bNEtvWoBT
        wcz1saAhwgIYr4DLaIJOXhRp/w/O
X-Google-Smtp-Source: APXvYqyIpLoRXkOYZbwFbmhPqTuuvllvwCJzoOR8vhkGIETBDQ6Zz+mgLVrVX3Hj2kGMIjindZeeZw==
X-Received: by 2002:a05:6830:1103:: with SMTP id w3mr19110206otq.61.1552504333107;
        Wed, 13 Mar 2019 12:12:13 -0700 (PDT)
Received: from [192.168.1.114] (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
        by smtp.gmail.com with ESMTPSA id e24sm4771217otl.2.2019.03.13.12.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 12:12:12 -0700 (PDT)
Subject: Re: [PATCH 17/17] nvme-tcp: support C2HData with SUCCESS flag
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Steve Blightman <steve.blightman@oracle.com>,
        Oliver Smith-Denny <osmithde@cisco.com>
References: <20190313175510.20725-1-hch@lst.de>
 <20190313175510.20725-18-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b0ddd0f2-4a4b-bab6-5d7d-07322be8a0a6@grimberg.me>
Date:   Wed, 13 Mar 2019 12:12:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313175510.20725-18-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph, what about nvmet-tcp side?
