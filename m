Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E330C05027
	for <linux-block@archiver.kernel.org>; Wed,  8 Feb 2023 18:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBHSEZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 13:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjBHSEY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 13:04:24 -0500
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8719276AE
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 10:03:44 -0800 (PST)
Received: by mail-pl1-f181.google.com with SMTP id m2so20241140plg.4
        for <linux-block@vger.kernel.org>; Wed, 08 Feb 2023 10:03:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDEyO+ma2QI9sRzCrtKLsV8tS9uDRvqr4KuU5JzbCL4=;
        b=meepAAh6ZE//c9zh1RjXNc8ImWN8k/lwd87GHHkyHqNTduGMbRvYBhH8sgzPKP/pek
         OiyfMnKOPBAFapehxJXS6p9BoDVOZruVstJ8CFOzVFVT2IqZYuRHjVD+IHiVr7PrO3U2
         zyLc5BFKvWoqNr7fyq35fP1UZU+qz4QUI2soUfAHlVzNTEQUWNFojeDUXGZgZYHBaKSm
         TTMpMAtTmR2eVYtKqqNrqOnjtbQuspYZwG2mUgayXLjBuf2w6mvwmcpq/MeYBQwPgXxy
         EhKz4Wuc1DJTSd3mQbXj08MAiXY/7sKbgduRarpeMpm9EuFGnlSG9SXZUF4z+uA/lpML
         fIvQ==
X-Gm-Message-State: AO0yUKX6RwrU/UZNQ9QCpYlzMnWWjcFF3Gez/5KRFxDYBZHQ7QzDFOPh
        1/G4j4xeVrH/zg9JPSbvpS8=
X-Google-Smtp-Source: AK7set/g+mb7SGW3fzmy9QKL5/cqTT6ysvQ8QC1TyGZ11GVL4W59XVMs+meQFCdxFWbkwjIb4uxf9w==
X-Received: by 2002:a17:902:da84:b0:196:8c85:8aaa with SMTP id j4-20020a170902da8400b001968c858aaamr9217479plx.6.1675879372052;
        Wed, 08 Feb 2023 10:02:52 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:869f:66a2:40c:445d? ([2620:15c:211:201:869f:66a2:40c:445d])
        by smtp.gmail.com with ESMTPSA id iz7-20020a170902ef8700b0019948184c33sm1855490plb.243.2023.02.08.10.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 10:02:51 -0800 (PST)
Message-ID: <b8f7da22-7a96-7676-ebf2-245041dfd09f@acm.org>
Date:   Wed, 8 Feb 2023 10:02:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [LSF/MM/BPF BoF]: extend UBLK to cover real storage hardware
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Liu Xiaodong <xiaodong.liu@intel.com>,
        Jim Harris <james.r.harris@intel.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        "hch@lst.de" <hch@lst.de>, Stefan Hajnoczi <stefanha@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
References: <Y+EWCwqSisu3l0Sz@T590>
 <80aa92bc-f9b3-f76e-4e3a-76d3753717d2@acm.org> <Y+L9Ijb5Kc3Yow5Z@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y+L9Ijb5Kc3Yow5Z@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/23 17:38, Ming Lei wrote:
> Here I meant we can export physical address of request sg from
> /dev/ublkb* to userspace, which can program the DMA controller
> using exported physical address. With this way, the userspace driver
> can submit IO without entering kernel, then with high performance.

Hmm ... security experts might be very unhappy about allowing user space 
software to program iova addresses, PASIDs etc. in DMA controllers 
without having this data verified by the kernel. Additionally, hardware 
designers every now and then propose new device multiplexing mechanisms, 
e.g. scalable IOV which is an alternative for SRIOV. Shouldn't we make 
the kernel deal with these mechanisms instead of user space?

Thanks,

Bart.

