Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51469 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755590AbdD1Oie (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 10:38:34 -0400
Date: Fri, 28 Apr 2017 16:38:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH 1/6] mtip32xx: get rid of 'atomic' argument to
        mtip_exec_internal_command()
Message-ID: <20170428143827.GA1443@lst.de>
References: <1493389911-19512-1-git-send-email-axboe@fb.com> <1493389911-19512-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493389911-19512-2-git-send-email-axboe@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
