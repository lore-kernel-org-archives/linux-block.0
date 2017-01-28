Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35592 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdA1AOd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jan 2017 19:14:33 -0500
Date: Fri, 27 Jan 2017 19:13:49 -0500
From: Tejun Heo <tj@kernel.org>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        linux-block@vger.kernel.org,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
Subject: Re: [PATCH V2 0/1] percpu-refcount: fix reference leak during
 percpu-atomic transition
Message-ID: <20170128001349.GB2476@mtj.duckdns.org>
References: <1485559936-14133-1-git-send-email-dougmill@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1485559936-14133-1-git-send-email-dougmill@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 27, 2017 at 05:32:15PM -0600, Douglas Miller wrote:
> Removed extraneous parentheses. Did not switch to "bool" as that would necessitate
> more testing and raises the question whether other platforms might have a different
> definition for "bool" that would not fix this problem.

Please switch to bool.

Thanks.

-- 
tejun
