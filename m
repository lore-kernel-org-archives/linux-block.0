Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA4DC04EB9
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF312145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 01:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF312145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeK3Mbl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 07:31:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36678 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Mbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 07:31:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so1754363pgm.3;
        Thu, 29 Nov 2018 17:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GDWps142+Tc+I1+Itx7UR8T4jMF4s6D+tfvgnEZb++8=;
        b=Z/QTcYvYlwdmHFzamiJ8mbQddWQCcm8luC9t3YpSVQs8h8ZLQQwluT7BPgOwgV1THn
         bxJvQju4Y/+4sDyaw7BWfF/xRlQavFWcHtuI+fJqxGyjIfuyS48EafOSJHlhQ5GdgM5c
         wlSNy1YSWFty5RvJLLxWIViQe1hUn9kLZpAcN9lKLOHytalWkUOF5sewTyDh8zzNgBxc
         ptYS7Jm+42RexCXo25iuEgRukTnWxqnVSrC6G0D3Ur5INSxpqOlTr3XJ8a/gGzudl7Ql
         mSaYunbnuqrPNJ95kB4sfJktzB+BlyJTyUBoENAwf+f5pJ/UMSzUJ7AFdpDi3daIEEjP
         DHqw==
X-Gm-Message-State: AA+aEWYYXjyPATKFv3BA2uJ7a4HEE+qIeN2yDM7GbxMXlcQYKlW2en7i
        82iMYFBz/g2fG7syyn5YbB8=
X-Google-Smtp-Source: AFSGD/WNQQU61WV9z7pueVXl9/nrDZt+pSFhCweph7Y4d8dU4nEpLy8j+voYInILspBlcbLPkvkgYg==
X-Received: by 2002:a62:59c9:: with SMTP id k70mr3620951pfj.243.1543541050320;
        Thu, 29 Nov 2018 17:24:10 -0800 (PST)
Received: from [10.1.124.47] ([199.36.244.14])
        by smtp.gmail.com with ESMTPSA id n186sm7175920pfn.137.2018.11.29.17.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 17:24:09 -0800 (PST)
Subject: Re: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181128070116.GB20369@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <133a9650-4413-8692-4200-9d54710e7358@grimberg.me>
Date:   Thu, 29 Nov 2018 17:24:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128070116.GB20369@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> What is the plan ahead here?  I think the nvme code looks pretty
> reasonable now (I'll do another pass at nitpicking), but we need the
> networking stuff sorted out with at least ACKs, or a merge through
> the networking tree and then a shared branch we can pull in.

I would think that having Dave ack patches 1-3 and taking it via the
nvme tree should be easier..

Dave? What would you prefer?
