Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32AC433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1322CF7
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 03:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596770419;
	bh=YKzqKSC5GPsC8hJnxF1Hb41vxHgIXfwocmztNoE+9eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bcz8SgBke12RHXJ8YXuGaA9QA5799VSHvS0AXDne3w9bCIs3y5STuyv0Dv1fN/Tln
	 8O5SjE6ahOd72rkwVv4ibEk97Pw1Kmmiu+POweNC4D7Z4SEt4LUJ8ZIO/ITdvDPwPr
	 +WFbzQL4rc8ZGeAdAuvaD/DDz+e2A6azxEUQl1pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGDUS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGDUR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Aug 2020 23:20:17 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C7222072D;
        Fri,  7 Aug 2020 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596770417;
        bh=YKzqKSC5GPsC8hJnxF1Hb41vxHgIXfwocmztNoE+9eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7JNGTP35/tFers/C4eli7hMicVoDtFIHd+Y/SKAa8lxI37laEoteP0KGlMAVJtQs
         DuQ2h4zWQ1C/InpadGdNfYqAnHr6mXgKiskFv+NbeZijrfFxHFVERUC8yqERQ7L4ap
         +Dtgo//wFf46AyDG2TakRpECQEljuV9NEcR6ymkg=
Date:   Thu, 6 Aug 2020 20:20:15 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Eric Deal <eric.deal@wdc.com>, stable@vger.kernel.org
Subject: Re: [PATCH] block: fix get_max_io_size()
Message-ID: <20200807032015.GB3797376@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200806215837.3968445-1-kbusch@kernel.org>
 <88d4db76-b912-8987-cfac-a2b926fbfe3d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d4db76-b912-8987-cfac-a2b926fbfe3d@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 06, 2020 at 05:28:17PM -0700, Bart Van Assche wrote:
> I think we agree that get_max_io_size() should never return zero. However, the above
> change seems wrong to me because it will cause get_max_io_size() to return zero if
> the logical block size is larger than 512 bytes and if sectors < lbs. 

I'm pretty sure we have more problems if 'sectors' isn't a multiple
of the logical block size.
