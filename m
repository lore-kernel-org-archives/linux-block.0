Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbcKUOuT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Nov 2016 09:50:19 -0500
Date: Mon, 21 Nov 2016 09:50:17 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Alasdair Kergon <agk@redhat.com>,
        "maintainer:DEVICE-MAPPER (LVM)" <dm-devel@redhat.com>,
        Shaohua Li <shli@kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>
Subject: Re: [PATCH 08/12] dm: dm.c: replace 'bio->bi_vcnt == 1' with
 !bio_multiple_segments
Message-ID: <20161121145017.GC23051@redhat.com>
References: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>
 <1478865957-25252-9-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478865957-25252-9-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Nov 11 2016 at  7:05am -0500,
Ming Lei <tom.leiming@gmail.com> wrote:

> Avoid to access .bi_vcnt directly, because the bio can be
> splitted from block layer, and .bi_vcnt should never have
> been used here.
> 
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>

I've staged this for 4.10
