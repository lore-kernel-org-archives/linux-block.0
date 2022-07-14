Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5706DC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiGNS1p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiGNS1l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:27:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27756A9E5
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:27:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 483E0342FD;
        Thu, 14 Jul 2022 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657823257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2qmBDHBqlMA8Bu7v0jZIoU3356sbGU30KbYyv3t56M=;
        b=TvG7fEE8C7gUo+gcjtxgCI51ICHaQMTBa3NQeraCVtcZDkSvvr0QDhY2twTLNjQqJRsuUA
        +JortXKo3hJ2yY7hkE8Hs4fJrTgyLf+EQNkPX+E4/IKRCMYAFY3AJHsB9lSV3cv41czLMq
        DvdPcJJswF0dW/wMae5hR/OKeEX1h20=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5262133A6;
        Thu, 14 Jul 2022 18:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JzbwNRhg0GJLDwAAMHmgww
        (envelope-from <mwilck@suse.com>); Thu, 14 Jul 2022 18:27:36 +0000
Message-ID: <68d958b1d02e557ac75fc604ce525eaad5779d29.camel@suse.com>
Subject: Re: [PATCH v3 42/63] scsi/device_handlers: Use the new blk_opf_t
 type
From:   Martin Wilck <mwilck@suse.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.com>
Date:   Thu, 14 Jul 2022 20:27:36 +0200
In-Reply-To: <20220714180729.1065367-43-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
         <20220714180729.1065367-43-bvanassche@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2022-07-14 at 11:07 -0700, Bart Van Assche wrote:
> Improve static type checking by using the new blk_opf_t type for
> variables
> that represent request flags.
>=20
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Martin Wilck <mwilck@suse.com>

