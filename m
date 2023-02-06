Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A56C61DA4
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 12:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBFMzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 07:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFMzp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 07:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D890214495
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 04:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675688097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K+jg2MDQ8zFuVv8INM8zR3Tx9pHjShGutK4vDD9pYLM=;
        b=a+K3fJegy86XT5dEO5ViTN0O5F4GdmKnB/v21VF9AMdaIp3J+c97H/N6N/S8hHtFyJBzGi
        YcOg4dTj6jTCTILbshthECmF+cYm6Cwk82tdw0cH7t7tjUueAxJurnd11AS399UaglCfdT
        /GeUIiHidxkbW170uEDf7BRys79wpC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-CNqVLlHoPmGo8-5twErLYw-1; Mon, 06 Feb 2023 07:54:51 -0500
X-MC-Unique: CNqVLlHoPmGo8-5twErLYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B99218027EB;
        Mon,  6 Feb 2023 12:54:50 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA39C15BA0;
        Mon,  6 Feb 2023 12:54:41 +0000 (UTC)
Date:   Mon, 6 Feb 2023 20:54:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hans Holmberg <Hans.Holmberg@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "andreas@metaspace.dk" <andreas@metaspace.dk>,
        "javier@javigon.com" <javier@javigon.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [LSF/MM/BPF BoF]: A host FTL for zoned block devices using UBLK
Message-ID: <Y+D4jImmZ2r3Wazg@T590>
References: <20230206100019.GA6704@gsv>
 <Y+D3Sy8v3taelXvF@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+D3Sy8v3taelXvF@T590>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 06, 2023 at 08:49:15PM +0800, Ming Lei wrote:
> > ublk adds a bit of latency overhead, but I think this is acceptable at least
> > until we have a great, proven solution, which could be turned into
> > an in-kernel FTL.
> 
> We will keep improving ublk io path, and I am working on ublk
> copy. Once it is done, big chunk IO latency could be reduced a lot.

s/copy/zero copy


Thanks,
Ming

