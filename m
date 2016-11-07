Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932167AbcKGPmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2016 10:42:55 -0500
Date: Mon, 7 Nov 2016 07:42:51 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: petero2@telia.com, axboe@fb.com, linux-block@vger.kernel.org
Subject: Re: [RFC, PATCH] pktcdvd: don't scribble over the bvec array
Message-ID: <20161107154251.GA12856@infradead.org>
References: <1477551884-25062-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477551884-25062-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Jens, is this something you could consider for 4.10?
