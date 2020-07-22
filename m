Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A41C433E2
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 17:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8D120717
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595440370;
	bh=vrnmZaIRwliX53vKBQ1d28+Q7Z0/op5TGz4Tmb8WGq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=B4/l+Vmqc1EmbVQ3S/xxqhWRk74Bt3SRMR3ADvhJYBKGX1KyNah/5luzBo8Lc0Pnl
	 PUr6OzuR+VRVXcshUjQT8FJYAA71wu+eZIAwxxQWoBKp656qgsJbspJ6uOf8yFuK72
	 t+uWvjmNSzORnCIsXFeRzCI2lqHMKxb3z2fB7WVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGVRwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGVRwt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 13:52:49 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98897207E8;
        Wed, 22 Jul 2020 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595440368;
        bh=vrnmZaIRwliX53vKBQ1d28+Q7Z0/op5TGz4Tmb8WGq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MT5KD0YChPzECugkAoboefewuQBRltWzpOPiPz+eGS/ldE9SkVjtBIHXxJ6AsKZy+
         eaelqTIBaEU9qQYYGbVy7BnKaL6SxxdeQmEE7XfPqIjxBKlkI3qJ0o1zfePMA19NI2
         fe2lG/NpdREikmYTJMHGU6ovyy3KqjDZ521FeDM0=
Date:   Wed, 22 Jul 2020 12:52:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] skd: use generic power management
Message-ID: <20200722175247.GA1293794@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721070939.GB51743@gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 21, 2020 at 12:39:39PM +0530, Vaibhav Gupta wrote:
> Okay. I will improve on it. Just inform me after testing that if any other
> changes are required. I guess [PATCH 1/3] and [PATCH 2/3] are okay, so I will
> only send v3 of [PATCH 3/3] after suggested changes.

FWIW, there's a recent conversation on users@linux.kernel.org about
updating individual patches in a series (sorry, can't find a link to
it).  But the gist of it was that posting only [v3 3/3] leads to
confusion because

  - we can't tell whether [v3 1/3] and [v3 2/3] got lost en-route, and

  - collecting things from v2 and v3 is more work for the maintainer.

Bottom line: repost the whole series, even if some patches haven't
changed.

Bjorn
