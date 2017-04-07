Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out0-224.mail.aliyun.com ([140.205.0.224]:55770 "EHLO
        out0-224.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752023AbdDGHjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Apr 2017 03:39:11 -0400
Reply-To: "Hillf Danton" <hillf.zj@alibaba-inc.com>
From: "Hillf Danton" <hillf.zj@alibaba-inc.com>
To: "'Vlastimil Babka'" <vbabka@suse.cz>,
        "'Andrew Morton'" <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "'Michal Hocko'" <mhocko@kernel.org>,
        "'Mel Gorman'" <mgorman@techsingularity.net>,
        "'Johannes Weiner'" <hannes@cmpxchg.org>,
        <linux-block@vger.kernel.org>, <nbd-general@lists.sourceforge.net>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <netdev@vger.kernel.org>, "'Michal Hocko'" <mhocko@suse.com>
References: <20170405074700.29871-1-vbabka@suse.cz> <20170405074700.29871-3-vbabka@suse.cz>
In-Reply-To: <20170405074700.29871-3-vbabka@suse.cz>
Subject: Re: [PATCH 2/4] mm: introduce memalloc_noreclaim_{save,restore}
Date: Fri, 07 Apr 2017 15:38:43 +0800
Message-ID: <092401d2af71$fc320ef0$f4962cd0$@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On April 05, 2017 3:47 PM Vlastimil Babka wrote: 
> 
> The previous patch has shown that simply setting and clearing PF_MEMALLOC in
> current->flags can result in wrongly clearing a pre-existing PF_MEMALLOC flag
> and potentially lead to recursive reclaim. Let's introduce helpers that support
> proper nesting by saving the previous stat of the flag, similar to the existing
> memalloc_noio_* and memalloc_nofs_* helpers. Convert existing setting/clearing
> of PF_MEMALLOC within mm to the new helpers.
> 
> There are no known issues with the converted code, but the change makes it more
> robust.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Acked-by: Hillf Danton <hillf.zj@alibaba-inc.com>
