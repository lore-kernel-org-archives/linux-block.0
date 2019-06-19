Return-Path: <SRS0=VMX8=US=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18F0C31E5D
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA52214AF
	for <linux-block@archiver.kernel.org>; Wed, 19 Jun 2019 17:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfFSRsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:48:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34531 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfFSRsI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jun 2019 13:48:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so43804pfc.1
        for <linux-block@vger.kernel.org>; Wed, 19 Jun 2019 10:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yKhym8zS2lbspt9P32ylyP8iRGQq1kBqQA2QAMU/aGw=;
        b=kO1E0fFCAJjOIYJUQnl1K2lrXEOQaIR8M+ARRAoWBV2/GlABcC8TKs13aMuIJeWMiZ
         zDyMU0T4COIoFloaCGv5nsAQ475zlWVF2coSAYEMfz8a35vN70yY0D9TuqsLkim+2Nt/
         jzYvJZwZfrwPpVTCoSSTqL2W0c98uDdgBafBcgHHS1eI+suacplKDdWgwJIJNG6UDp7/
         G8xQq+QTQHSK44ND6TlLJI7m+Otk/3ozjTfiGVi/BidnK8oQEmMqiYHn2flCH84iVxZX
         dcQrJIYf31ACLA13xqBFNyFJebqEiyCREioTF4+wtzBPLrRVuZ2VrHAPCxoSqlMd4FyJ
         Ej7A==
X-Gm-Message-State: APjAAAW364laTIXJv1TnCipQz57/xvGSrQ9e5NTVLUWygzmkE/yNTTvv
        SHQdF3OxxBG9Y03LEfrp/ViaAa/N
X-Google-Smtp-Source: APXvYqzKbJ0VsXchxff08s6ZbLQIff8vx4K+Me4Zc1H5BEoQtkipDOv2z0W4up6uIKaYvrQgY2R53g==
X-Received: by 2002:a63:2249:: with SMTP id t9mr8918080pgm.149.1560966487576;
        Wed, 19 Jun 2019 10:48:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t7sm2488840pjq.20.2019.06.19.10.48.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:48:06 -0700 (PDT)
Subject: Re: [PATCH V4 1/5] block: improve print_req_error
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
Cc:     jaegeuk@kernel.org, yuchao0@huawei.com
References: <20190619171302.10146-1-chaitanya.kulkarni@wdc.com>
 <20190619171302.10146-2-chaitanya.kulkarni@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9b490eac-198c-0951-1abd-76780353419c@acm.org>
Date:   Wed, 19 Jun 2019 10:48:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619171302.10146-2-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/19 10:12 AM, Chaitanya Kulkarni wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Print the calling function instead of print_req_error as a prefix, and
> print the operation and op_flags separately instead of the whole field.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
