Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D194CC433E1
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 00:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8551A207FB
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 00:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9e1jYJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgHSAAZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:00:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52660 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726676AbgHSAAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 20:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597795223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eOn0ZILfzM23ljxe/i9GUKkqEJ5k7iDa6Ji70/MpTwA=;
        b=e9e1jYJ1UkR62LiGZYVmUjjxv/4q1nZcncmWKJ/QBfiq8Pbxpjc1mz7vtBOwTEfVeqE2dN
        PmyOUsAVWjY62MhtZTfsmTGewdevW95NhLV295gTeKDlywu5zeUF8nzNkw9P+8z9s36zFl
        qvX06oNgykpzd4SZaAUdJTAU9lWJVvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-KruE4g-GNOaipWmY0zK3yw-1; Tue, 18 Aug 2020 20:00:21 -0400
X-MC-Unique: KruE4g-GNOaipWmY0zK3yw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884581DDFC;
        Wed, 19 Aug 2020 00:00:20 +0000 (UTC)
Received: from T590 (ovpn-12-56.pek2.redhat.com [10.72.12.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 780D4101417D;
        Wed, 19 Aug 2020 00:00:14 +0000 (UTC)
Date:   Wed, 19 Aug 2020 08:00:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [REPORT] BUG: KASAN: use-after-free in bt_iter+0x80/0xf8
Message-ID: <20200819000009.GB2712797@T590>
References: <8376443a-ec1b-0cef-8244-ed584b96fa96@huawei.com>
 <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68379af-48e7-da2b-812c-ff0fa24a41bb@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 07:19:57PM +0100, John Garry wrote:
> On 18/08/2020 13:03, John Garry wrote:
> > Hi guys,
> > 
> > JFYI, While doing some testing on v5.9-rc1, I stumbled across this:
> 
> I bisected to here (hopefully without mistake):

This one is a long-term problem, see the following discussion:

https://lore.kernel.org/linux-block/1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com/


Thanks,
Ming

