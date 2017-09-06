Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34075 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932100AbdIFNo5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2017 09:44:57 -0400
Date: Wed, 6 Sep 2017 06:44:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <jg@lightnvm.io>
Cc: mb@lightnvm.io, axboe@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>
Subject: Re: [PATCH] lightnvm: Add error code for bad write pointer
Message-ID: <20170906134456.GB3960@infradead.org>
References: <1504693358-12702-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1504693358-12702-1-git-send-email-javier@cnexlabs.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 06, 2017 at 12:22:38PM +0200, Javier Gonz�lez wrote:
> Add new error code introduced on the OCSSD spec 2.0 for write pointer
> mismatch on the device side. This indicates to the host that a write on
> a block (chunk) is not respecting the required sequentiality.

Do you have a pointer to that spec?
