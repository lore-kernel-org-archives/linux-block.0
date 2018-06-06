Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFFNPX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jun 2018 09:15:23 -0400
Date: Wed, 6 Jun 2018 06:15:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Milan Broz <gmazyland@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        device-mapper development <dm-devel@redhat.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] md: dm-crypt: Add Inline Encryption support for dmcrypt
Message-ID: <20180606131515.GB12737@infradead.org>
References: <e9120efc-1e25-79c8-6132-9062dd030539@synopsys.com>
 <7a510610-9133-39aa-6841-3925c532f3c0@gmail.com>
 <BD7FB879CC136E419544C8E2AE7B9C3020BB94@IN01WEMBXA.internal.synopsys.com>
 <20180601081642.GA25973@infradead.org>
 <BD7FB879CC136E419544C8E2AE7B9C3020C5D6@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C3020C5D6@IN01WEMBXA.internal.synopsys.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 06, 2018 at 10:04:14AM +0000, Ladvine D Almeida wrote:
> The idea is to make use of the existing utilities like dmsetup to configure the keys, mapping etc.

So fix the utilities to support your encryption instead of implementing
kernel-level shim code.

> TCG Opal/Opalite is FDE solution. right?

Doesn't have to the full disk, although that is the typical use case.
