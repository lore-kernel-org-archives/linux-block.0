Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44867 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKHbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 May 2017 03:31:45 -0400
Date: Thu, 11 May 2017 00:31:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 5/9] bio-integrity: fold bio_integrity_enabled to
 bio_integrity_prep
Message-ID: <20170511073145.GB26586@infradead.org>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
 <1494429652-9488-6-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494429652-9488-6-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
