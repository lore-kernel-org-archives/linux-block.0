Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4042FC10F0F
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3F121852
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 13:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDEN66 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:58:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36012 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDEN66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 09:58:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so3133014pgc.3;
        Fri, 05 Apr 2019 06:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wj9JigKsldnfsOKQDnadLIfLpVxZve/O2OXs8G+iNxQ=;
        b=apZWw/1fsRCVSq13pDBc37KP+vK01tzXY1uUvGqg7PMN2BAWY0uyhciiD0NbpkfEOO
         /nbJjMdsy4B/siIA1USn4FAqdIsBeycRPyys6I8xqIgOx9KhvCtbCbEbi/IghKstDbRY
         hrixflQYfB2FUkb86Ql7y/+7et9Q/lE/w5NqWc8kyWua2m5wexPY1Xg6kianSdZZ0AHw
         PQJFXcAsC59+1pQXDTaiZkylsqAPNhij73a2gOs84diY7VYZVHP1ExBuHyLGlkE3a9zN
         WwFbvFZ+ItAj4vUs8fSHa3oLQp+ZMzvHoNZIR5+Z6uQK1yy3U7c0l5s8txuqxJr+VEvD
         /h3Q==
X-Gm-Message-State: APjAAAWXdRE363L+Nu20puXJaLFca0lJggsAdWrnYmfNW5y3AHReWNBV
        OA/52enNFsD4ImftmAU0eRk05i//F/U=
X-Google-Smtp-Source: APXvYqxAyYOqDQX0BtuyMZs2S37reHuEp6DLExKNe6zO+qjStuOgtm/w2qxukQRdve7E19KPKIBKiQ==
X-Received: by 2002:a63:530e:: with SMTP id h14mr12184575pgb.136.1554472735773;
        Fri, 05 Apr 2019 06:58:55 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id x8sm12601348pgp.48.2019.04.05.06.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 06:58:55 -0700 (PDT)
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
To:     Laurence Oberman <loberman@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
References: <20190404170843.83517-1-bvanassche@acm.org>
 <20190405060612.GA32144@lst.de>
 <72814f8faee5f55d661863321e48f2a7ef521c63.camel@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <309a4153-ac19-a23a-a170-9f1ddf31a172@acm.org>
Date:   Fri, 5 Apr 2019 06:58:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <72814f8faee5f55d661863321e48f2a7ef521c63.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 5:43 AM, Laurence Oberman wrote:
> On Fri, 2019-04-05 at 08:06 +0200, Christoph Hellwig wrote:
>> On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
>>> blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for
>>> requests that
>>> have been queued. If that happens when blk_mq_try_issue_directly()
>>> is called
>>> by the dm-mpath driver then dm-mpath will try to resubmit a request
>>> that is
>>> already queued and a kernel crash follows. Since it is nontrivial
>>> to fix
>>> blk_mq_request_issue_directly(), revert the
>>> blk_mq_request_issue_directly()
>>> changes that went into kernel v5.0.
>>
>> And what are we going to do about 5.1+?
> 
> All the testing of the reverts etc. was agains 5.1-rc3.
> I believe the intention is to revert for 5.1x+ and earlier.

I think the revert should happen for the v5.0 and v5.1 kernels, hence 
the "Cc: stable" tag.

Bart.
