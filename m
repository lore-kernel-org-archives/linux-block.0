Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39546 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751010AbcIVNtd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Sep 2016 09:49:33 -0400
Subject: Re: [PATCH] block: export bio_free_pages to other modules
To: Guoqing Jiang <gqjiang@suse.com>, <linux-block@vger.kernel.org>
References: <1474528201-23359-1-git-send-email-gqjiang@suse.com>
CC: Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, Shaohua Li <shli@fb.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <073a35bb-7b09-e47b-b0d9-d177aab8aba1@fb.com>
Date: Thu, 22 Sep 2016 07:48:39 -0600
MIME-Version: 1.0
In-Reply-To: <1474528201-23359-1-git-send-email-gqjiang@suse.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/22/2016 01:10 AM, Guoqing Jiang wrote:
> bio_free_pages is introduced in commit 1dfa0f68c040
> ("block: add a helper to free bio bounce buffer pages"),
> we can reuse the func in other modules after it was
> imported.

Applied for 4.9, thanks.

-- 
Jens Axboe

