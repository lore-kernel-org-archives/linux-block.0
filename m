Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEACC636D3
	for <linux-block@archiver.kernel.org>; Mon,  6 Feb 2023 15:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBFPh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjBFPhO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 10:37:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE642CC57
        for <linux-block@vger.kernel.org>; Mon,  6 Feb 2023 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675697585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKHI0Wy0T86RQkMFeV1Ey6JGOPoag2ZW2fh/VT586FE=;
        b=eJlwHV5lLPizfI3F23L8JSsE0D1nxhD4hLYQMSdHA7g7tC3wPHO8ufm5SqokwuqL9SNpd7
        HvvY6omomjeJDzfh+hQvcT9R6OFgOonWGXuQRawvPpRP4rXfAavGxAPlxe5GkrUVYxwYQ0
        ZYbX6mypSbfgwfepi0JnPtUYH+2hK70=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-Jm7n5xx6PfS0RgK2UIAPMA-1; Mon, 06 Feb 2023 10:32:59 -0500
X-MC-Unique: Jm7n5xx6PfS0RgK2UIAPMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 651401C05147;
        Mon,  6 Feb 2023 15:32:58 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65009440BC;
        Mon,  6 Feb 2023 15:32:48 +0000 (UTC)
Date:   Mon, 6 Feb 2023 23:32:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
Message-ID: <Y+EdnFJ1IwQakFsr@T590>
References: <20230206100019.GA6704@gsv>
 <Y+D3Sy8v3taelXvF@T590>
 <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN8PR04MB6417488E54789C123E6EAA4AF1DA9@BN8PR04MB6417.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Matias,

On Mon, Feb 06, 2023 at 02:34:51PM +0000, Matias Bjørling wrote:
> > Maybe it is one beginning for generic open-source userspace SSD FTL, which
> > could be useful for people curious in SSD internal. I have google several times
> > for such toolkit to see if it can be ported to UBLK easily. SSD simulator isn't
> > great, which isn't disk and can't handle real data & workloads. With such
> > project, SSD simulator could be less useful, IMO.
> > 
> 
> Another possible avenue could be the FTL module that's part of SPDK. It might be worth checking out as well. It has been battletested for a couple of years and is used in production (https://www.youtube.com/watch?v=qeNBSjGq0dA).
> 
> The module itself could be extracted from SPDK into its own, or SPDK's ublk extension could be used to instantiate it. In any case, I think it could provide a solid foundation for a host-side FTL implementation.

Great, I will take a look, and thanks for the sharing!

Thanks,
Ming

