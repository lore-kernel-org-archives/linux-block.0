Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727865AbeGVIYB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Jul 2018 04:24:01 -0400
Date: Sun, 22 Jul 2018 15:28:05 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Josef Bacik <jbacik@fb.com>
Cc: Ming Lei <tom.leiming@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [Bug] block/for-next: IO hang in rq_qos_throttle
Message-ID: <20180722072804.GA955@ming.t460p>
References: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
 <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jul 22, 2018 at 02:15:38AM +0000, Josef Bacik wrote:
> Yup I sent a patch for this on Thursday, sorry about that,
> 

I just applied the patch of 'blk-rq-qos: make depth comparisons unsigned',
looks the same IO hang can be triggered too.

Thanks,
Ming
