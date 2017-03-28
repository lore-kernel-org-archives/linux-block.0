Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39231 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbdC1GcQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2017 02:32:16 -0400
Date: Mon, 27 Mar 2017 23:32:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 1/6] hd: stop sharing request queue across multiple
 gendisks
Message-ID: <20170328063213.GA11751@infradead.org>
References: <cover.1490681910.git.osandov@fb.com>
 <dc3e8fc2dd692fc27f43c51eaf607ea0c3ddda5f.1490681910.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dc3e8fc2dd692fc27f43c51eaf607ea0c3ddda5f.1490681910.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Can we just remove this driver entirely?  I'm pretty sure Linux will
have all kinds of problems with hardware of that age anyway.
