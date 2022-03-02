Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C40DC433EF
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 21:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbiCBVOu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245246AbiCBVOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 16:14:04 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70BDD97B
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 13:12:01 -0800 (PST)
Received: by mail-pg1-f175.google.com with SMTP id w37so2684296pga.7
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 13:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EQ7hQXKrcCfMYiAJJ2Vp/L1VmTunX+o/lAMH/6D6On0=;
        b=wFaxM14rHHGIOcfAPB94nRU/xtlhlHv6AoqKl+v//0UhDrFIyVxXTt+Kt3llRDtsVz
         AiJD0hWUqDLpz0VUlHaMrNrYhqyL4ua4pYdS9pstr3NcVOLWyec/84A/RT8uz3w1RQp5
         6srE7VlZU6/ubpZW0gX+9aUpG5dIAVHCeMzVMvgT8G9WpAYDXkwMnWt3gT4m90oKqefd
         3OkUygWKmF1ZXQkxiJKEyrlPr9il7l1rH+Ojj82LnRtzavLQjgNR4G7+6zUUSbCp6qZX
         2zYbG0uyN61ihRQGdup55w+Xcq4gGZTKTSzoYp96Z7KivniVtzNH+OEA/3SFM4jwqZF1
         GL0Q==
X-Gm-Message-State: AOAM532rfFhjInJ26Cf2IIWUiUo+uE8xQyd80PcDM9fIC11TBE2yVnI1
        6B6u/j27FtkT8zbVVgvRpWk=
X-Google-Smtp-Source: ABdhPJzRVIuKzFElwx57vxv3s3OLXXzLQAoXcmK4bLK3p0jluiwb9oCqlcNJgLPb6snR1ZvYxTecaw==
X-Received: by 2002:a63:18f:0:b0:37c:4671:a2ce with SMTP id 137-20020a63018f000000b0037c4671a2cemr2311322pgb.429.1646255514362;
        Wed, 02 Mar 2022 13:11:54 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00194900b004e1583f88a2sm93138pfk.0.2022.03.02.13.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:53 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:11:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
        "Remzi H. Arpaci-Dusseau" <remzi@cs.wisc.edu>
Cc:     Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <Keith.Busch@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Ajay Joshi <Ajay.Joshi@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Judy Brock <judy.brock@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20220302211150.ibyvunpathxjvi6t@garbanzo>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 17, 2020 at 09:23:05PM +0200, Matias Bjørling wrote:
> On 17/06/2020 21.09, Javier González wrote:
> > As you are well aware, there are some cases where append introduces
> > challenges. This is well-documented on the bibliography around nameless
> > writes.
> 
> The nameless writes idea is vastly different from Zone append, and have
> little of the drawbacks of nameless writes, which makes the well-documented
> literature not apply.

Sorry for joining late to the party!

Just curious if we have any public information on analysis on the
differences between zone append and nameless writes?

If we don't then this sould seem to be new territory? I'd expect many
drawbacks might not be known yet. In new filesystem APIs we know all these
things will always creep up. Not that there couldn't be unexpected issues for
nameless writes once and if someone did try to add support for it in a real
OS. But if nameless writes is pretty much append, it gives me a good idea
where to expect some issues ahead of time.

Thanks!

  Luis
