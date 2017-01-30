Return-Path: <linux-block-owner@vger.kernel.org>
Received: from resqmta-ch2-12v.sys.comcast.net ([69.252.207.44]:58472 "EHLO
        resqmta-ch2-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932399AbdA3QUS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 11:20:18 -0500
Date: Mon, 30 Jan 2017 10:04:49 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>
cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org, stable@vger.kernel.org,
        Guilherme Piccoli <gpiccoli@br.ibm.com>
Subject: Re: [PATCH V3 1/1] percpu-refcount: fix reference leak during
 percpu-atomic transition
In-Reply-To: <1485607340-13728-1-git-send-email-dougmill@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1701301004350.1287@east.gentwo.org>
References: <1485607340-13728-1-git-send-email-dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


Acked-by: Christoph Lameter <cl@linux.com>


