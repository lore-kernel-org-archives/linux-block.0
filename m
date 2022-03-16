Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA5CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 00:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352791AbiCPAYx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCPAYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 20:24:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41133343
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=CFP2Sru0tYWchcwqq3XzxvQJc3sFwx3lg2SlcC28hc0=; b=OL12+oubQiQaoUCs/9gfYpVldG
        b3iE3sKblbJWIT1WfttAAWgt7gJ3hu6/tFOw5mRvjv0qZPLoKOrfSiDFZqIKuxyDTbc2AC8SxBsA5
        2rDfhds2hDJljEZJifa2vcCDP5ot6qVuKqV92FSHIaANfMipkhDbla7hMYpbnHL6/6A7Gi9ADs0xB
        zmup15r4lI/3ai64S4EsAHMwGnVCxtY7IuL4P6LUZH6gXbngvpDne7I6KISdHKIhK7MW2AFblxo3J
        C82Wyd+d93sN1LC10HoXdj2usSB+MlHzh4Ngag+7zsY5s+FZC+V2JyVBOG4h/Xl/TRTqlIHt5utax
        y154Ingw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUHRq-00AzZ8-Hf; Wed, 16 Mar 2022 00:23:30 +0000
Date:   Tue, 15 Mar 2022 17:23:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
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
Message-ID: <YjEuAv/RNpF4GvsJ@bombadil.infradead.org>
References: <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
 <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315132611.g5ert4tzuxgi7qd5@unifi>
 <20220315133052.GA12593@lst.de>
 <YjDGS6ROx6tI5FBR@bombadil.infradead.org>
 <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ed2891-f4b2-d63c-553d-8cae49b586bc@opensource.wdc.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 09:07:18AM +0900, Damien Le Moal wrote:
> On 3/16/22 02:00, Luis Chamberlain wrote:
> > On Tue, Mar 15, 2022 at 02:30:52PM +0100, Christoph Hellwig wrote:
> >> On Tue, Mar 15, 2022 at 02:26:11PM +0100, Javier González wrote:
> >>> but we do not see a usage for ZNS in F2FS, as it is a mobile
> >>> file-system. As other interfaces arrive, this work will become natural.
> >>>
> >>> ZoneFS and butrfs are good targets for ZNS and these we can do. I would
> >>> still do the work in phases to make sure we have enough early feedback
> >>> from the community.
> >>>
> >>> Since this thread has been very active, I will wait some time for
> >>> Christoph and others to catch up before we start sending code.
> >>
> >> Can someone summarize where we stand?
> > 
> > RFCs should be posted to help review and evaluate direct NPO2 support
> > (not emulation) given we have no vendor willing to take a position that
> > NPO2 will *never* be supported on ZNS, and its not clear yet how many
> > vendors other than Samsung actually require NPO2 support. The other
> > reason is existing NPO2 customers currently cake in hacks to Linux to
> > supoport NPO2 support, and so a fragmentation already exists. To help
> > address this it's best to evaluate what the world of NPO2 support would
> > look like and put the effort to do the work for that and review that.
> 
> And again no mentions of all the applications supporting zones assuming
> a power of 2 zone size that will break.

What applications? ZNS does not incur a PO2 requirement. So I really
want to know what applications make this assumption and would break
because all of a sudden say NPO2 is supported.

Why would that break those ZNS applications?

> Allowing non power of 2 zone size may prevent applications running today
> to run properly on these non power of 2 zone size devices. *not* nice.

Applications which want to support ZNS have to take into consideration
that NPO2 is posisble and there existing users of that world today.

You cannot negate their existance.

> I have yet to see any convincing argument proving that this is not an issue.

You are just saying things can break but not clarifying exactly what.
And you have not taken a position to say WD will not ever support NPO2
on ZNS. And so, you can't negate the prospect of that implied path for
support as a possibility, even if it means work towards the ecosystem
today.

 Luis
