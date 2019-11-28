Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEB1C432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 15:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0172178F
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 15:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NHjInXez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK1Pyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 10:54:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK1Pyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 10:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=M7wa2eYP8n8bEo5wUF/1ZUe+1l62DJk2bgC8MhhDcWk=; b=NHjInXez6NpLI5NrOhBl6GRca
        d5U9QaifWR9l6XE8K3jP15QhlLjODuTN/P0YTkB/00QikEBv5xNvfckbM4Q9AJO5ElbfuYofi6R6Q
        X1TK7FRKJrkoVx0a4MTdS5rVVROpwH2uEjz4NalPjazU5UynV8y1wVn18yh7YztdwA7tUJTnRQvuw
        cKxXBF7L1qQdGrYXhQnVKqc9ENF7lf2vbCwgzzg7xQN45HiP4YngQkY48D2kF1j7RH85zqT/3TBPS
        7e4Vyd7Gr5fWKa3Mp2HdlcrcHdEWknua68ZmedZkNzafuTMygvdXZteMhO4py08gNrT+yvYVacTQm
        hqvrBbr+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaM7e-0000I6-6c; Thu, 28 Nov 2019 15:54:26 +0000
Date:   Thu, 28 Nov 2019 07:54:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH v6 0/4] Add MMC software queue support
Message-ID: <20191128155426.GA31042@infradead.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
 <CAK8P3a1we9D5C2NOBww=cW-4L1PT3t0NnDRmknLwiLm652TmKg@mail.gmail.com>
 <CAMz4kuK9HEuGdhNqHO_qoy9jD=ccsPPhD_dKYwNRgQyWyYwqRA@mail.gmail.com>
 <CAK8P3a0rNhyxmUWLUV1js3FsuAESDOPX3E4b8ActtL4GRT4uTA@mail.gmail.com>
 <CADBw62pzV+5ZXBEbFvTQJ9essAd4cd7Xkz5j9AXB5rAQy0wLqA@mail.gmail.com>
 <CAMz4kuK_3q4JY1vNXe6zGHDNF8Ep-SkcUq6Z25r790VSz4+Bjw@mail.gmail.com>
 <CAK8P3a11vJb1riYseqPnF_5SuJA+YnYuGwC0XWx6_rk+eQ0Bmw@mail.gmail.com>
 <f88856aa-9175-2a93-3747-c98215cb79c3@suse.de>
 <20191127090023.GA23040@infradead.org>
 <yq1v9r46vua.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1v9r46vua.fsf@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 28, 2019 at 07:15:09AM -0500, Martin K. Petersen wrote:
> This mirrors single_lun in SCSI closely. I was hoping we could
> eventually get rid of that travesty but if MMC needs something similar,
> maybe it would be good to move that plumbing to block?

Oh, I totally forgot about single_lun.  Given that it is only set
for ancient CD changers I'm not even sure that code works properly
anymore.  Having common code that is exercised regularly by mmc would
certainly be better than the current SCSI code, but I'm not sure how
well this is going to work out.
