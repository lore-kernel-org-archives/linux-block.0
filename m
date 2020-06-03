Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465AEC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2466E20678
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Tn0Ou57h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFCIZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCIZH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 04:25:07 -0400
X-Greylist: delayed 157670 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 03 Jun 2020 01:25:07 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D0C05BD43;
        Wed,  3 Jun 2020 01:25:07 -0700 (PDT)
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 2525C2E1577;
        Wed,  3 Jun 2020 11:25:04 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id e8ZNCm3DrZ-P1B8bnrV;
        Wed, 03 Jun 2020 11:25:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591172704; bh=bjcO2fjrffTG2/nSxMZQKpT6zNR/iSjneL2Z3vT4BSg=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Tn0Ou57hNqHtw9FxJ6+f56M9geYlxT2UVy6IyaPCgoHdTgOZnDykC0Ky7rxfK/tZp
         tK3yIcV2O+cxidL7svN/T4SjiqEVN6uIwGMQIC4rjlhHaSGJASAiQn1DqQxb+Ok3QC
         6AZc4dXW8k8R51yHQeNOscnayt7bsck0NEgJaCOM=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7216::1:b])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id YEeyNlG2dn-P1WmCXdR;
        Wed, 03 Jun 2020 11:25:01 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC 1/3] block: add flag 'nowait_requests' into queue
 limits
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <159101473169.180989.12175693728191972447.stgit@buzz>
 <159101502963.180989.6228080995222059011.stgit@buzz>
 <20200603045822.GA17137@infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <2a58bc7a-0aad-3f40-cb8e-db9cb88f9df4@yandex-team.ru>
Date:   Wed, 3 Jun 2020 11:24:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603045822.GA17137@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/06/2020 07.58, Christoph Hellwig wrote:
> On Mon, Jun 01, 2020 at 03:37:09PM +0300, Konstantin Khlebnikov wrote:
>> Add flag for marking bio-based queues which support REQ_NOWAIT.
>> Set for all request based (mq) devices.
>>
>> Stacking device should set it after blk_set_stacking_limits() if method
>> make_request() itself doesn't delay requests or handles REQ_NOWAIT.
> 
> I don't think this belongs into the queue limits.  For example a
> stacking driver that always defers requests to a workqueue can support
> REQ_NOWAIT entirely independent of the underlying devices.  I think
> this just needs to be a simple queue flag.
> 

For O_DIRECT I/O REQ_NOWAIT not just about non-blocking submition.
It also provides instant feedback about contention. Like ECN from network.
This feedback is useful for rate-control and balancing load between replicas.

If upper layer simply remaps and forwards requests below then to forward
contention all layers of stacked device should support this feature.
That's why I've put it as flag into limits - to reuse limits stacking.

If any layer defers request, then it should somehow limit size of backlog
at the same time to provide sane behaviour for REQ_NOWAIT regardless of
behaviour lower devices. So, then it could simply set that flag in limits.

Also I want to add handing into blk-qos/throttler - never delay REQ_NOWAIT.
