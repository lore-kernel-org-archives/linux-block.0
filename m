Return-Path: <SRS0=9GNQ=6H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB73EC55185
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 00:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8F802075A
	for <linux-block@archiver.kernel.org>; Thu, 23 Apr 2020 00:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDWALp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:11:45 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42767 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDWALp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 20:11:45 -0400
Received: by mail-pg1-f180.google.com with SMTP id g6so1947015pgs.9;
        Wed, 22 Apr 2020 17:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=emvX2TuOhwJKO5Np6bMVJJQyoQHcq6HF07rlZVhPO/g=;
        b=V2tUNhZcYNFpqkotUPFFsIKLkKJDPTDZGL8QcRaUmsFbeHxGatKgzZwSTZVdvWsxpY
         siItmsOl11pY/K+vVGlzkonNGPW0ftOGRw3I5jE/jkDm123tD/l07dYO7zTSO5r54eyL
         fWqFKJ6IcK5sYpPGCWFp1J7XU9ZM/j6CIx4M2CX9Qv7cYg+E1RjyAYxAGAfKHI74dtMD
         ZrDtk5zvrDDk5I6b1MOAlJTA2S+D5HD+ZHtjRj2X2DLI/G8WB/E8YXXnLcfDa3XnrybY
         WNNqaKgR6KIAG6JEQUTPRPgkiAPETJP9QWJIJEzIE8wS+JfhspT9leI7QtBM4EaIcvW8
         pB1A==
X-Gm-Message-State: AGi0PuY+p/dyEzF/jMoHDt9Eapb0ZyMyyLIMllqlXWokWADs12WF2Cqd
        meh1uqVfUadH5xU2DBvFb1XByf8zDHo=
X-Google-Smtp-Source: APiQypLFxDobE0qmtQEHzU1jWrxyStiGtEnt+ustkbAtt9fP2tcW+vhju7QwxnJtU7k2aMmAZSbTZw==
X-Received: by 2002:a62:d086:: with SMTP id p128mr1142350pfg.241.1587600703949;
        Wed, 22 Apr 2020 17:11:43 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id d29sm23467pgm.83.2020.04.22.17.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:11:43 -0700 (PDT)
Subject: Re: [PATCH 6/9] bdi: unexport bdi_register_va
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-7-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e5103392-5b3f-606f-27ea-c9b0cbd1333c@acm.org>
Date:   Wed, 22 Apr 2020 17:11:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:
> bdi_register_va is only used by super.c, which can't be modular.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

