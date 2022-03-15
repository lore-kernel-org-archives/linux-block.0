Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFFBC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 13:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348692AbiCONcJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348681AbiCONcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 09:32:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482B51307
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 06:30:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 162D968AA6; Tue, 15 Mar 2022 14:30:53 +0100 (CET)
Date:   Tue, 15 Mar 2022 14:30:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Message-ID: <20220315133052.GA12593@lst.de>
References: <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com> <20220314073537.GA4204@lst.de> <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com> <20220314104938.hv26bf5vah4x32c2@ArmHalley.local> <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com> <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local> <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com> <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain> <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com> <20220315132611.g5ert4tzuxgi7qd5@unifi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315132611.g5ert4tzuxgi7qd5@unifi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
> but we do not see a usage for ZNS in F2FS, as it is a mobile
> file-system. As other interfaces arrive, this work will become natural.
>
> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
> still do the work in phases to make sure we have enough early feedback
> from the community.
>
> Since this thread has been very active, I will wait some time for
> Christoph and others to catch up before we start sending code.

Can someone summarize where we stand?  Between the lack of quoting
from hell and overly long lines from corporate mail clients I've
mostly stopped reading this thread because it takes too much effort
actually extract the information.
