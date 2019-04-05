Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8FCC10F00
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65B821852
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbfDEOA2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:00:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39688 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbfDEOA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 10:00:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so3132292pga.6;
        Fri, 05 Apr 2019 07:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOYK0huQCxaBCXxS9kfbcTcQRYlnlZt8LC94WIpkZY8=;
        b=J9vXKPm2lQYaznVYUEJYNMYE8BmcvcCmRWFc4/FxXT2odv079TjFvKuHwsAirGwa07
         lFEiCZK1Zmx6XKXYW/OUzB1z82XSP7c6d+D4lmbnS0AV9ESIBhRDUsF8jw0Om/BOsWiB
         3HJ45NFMY89ygU3JVh7ye1CydkshJfTU6MOforzKeUmMpjqQVEyRhmx2s6mVTU4qQXy9
         AJT0owxyuJieUsPE69czOEtGppqAXBXEFToHpSXzxdZO7nF124Q4UB+hO4k3+LtM7Pvm
         T+5aKjS7z9banY7sNwMst2VrWErtbkylDeSGqgezmTccLJ2cCfOltkim3fG6ncitMbKj
         5wQQ==
X-Gm-Message-State: APjAAAXzIEtDlLeeAPc7N8b2+pAC7D66OvA1N+503wuOs8wrvYpMxWti
        CP2ZFTJb0OdwQPe0yT9uh8VY0ONmJq0=
X-Google-Smtp-Source: APXvYqwZXfgV3JbaRPvsFqocR2ExEzhaH3XJYFc2HY9GsIrQtRTQ9qSRchuvGndy3jb1Du+dt/yquA==
X-Received: by 2002:a63:6786:: with SMTP id b128mr12354481pgc.318.1554472825286;
        Fri, 05 Apr 2019 07:00:25 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id y19sm30957206pfn.164.2019.04.05.07.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 07:00:24 -0700 (PDT)
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
References: <20190404170843.83517-1-bvanassche@acm.org>
 <20190405060612.GA32144@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <fd4c63a9-6eaa-f104-6f33-0dfcd2dc6eba@acm.org>
Date:   Fri, 5 Apr 2019 07:00:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190405060612.GA32144@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/4/19 11:06 PM, Christoph Hellwig wrote:
> On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
>> blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for requests that
>> have been queued. If that happens when blk_mq_try_issue_directly() is called
>> by the dm-mpath driver then dm-mpath will try to resubmit a request that is
>> already queued and a kernel crash follows. Since it is nontrivial to fix
>> blk_mq_request_issue_directly(), revert the blk_mq_request_issue_directly()
>> changes that went into kernel v5.0.
> 
> And what are we going to do about 5.1+?

Hi Christoph,

This patch was developed and tested on my setup against Jens' for-next 
branch. So this patch should apply fine on kernel v5.1-rc3.

Bart.

