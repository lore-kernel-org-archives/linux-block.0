Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFDC433EF
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 11:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF54F61A8B
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 11:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353780AbhJALcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 07:32:10 -0400
Received: from submit01.uniweb.no ([5.249.227.132]:59115 "EHLO
        submit01.uniweb.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353652AbhJALcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 07:32:10 -0400
X-Greylist: delayed 1489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Oct 2021 07:32:09 EDT
Received: from [10.20.0.27] (helo=mail.uniweb.no)
        by submit01.uniweb.no with esmtpa (Exim 4.93)
        (envelope-from <odin@digitalgarden.no>)
        id 1mWGMB-007IMK-Fy; Fri, 01 Oct 2021 13:05:35 +0200
Date:   Fri, 1 Oct 2021 13:05:34 +0200
From:   Odin Hultgren van der Horst <odin@digitalgarden.no>
To:     linux-block@vger.kernel.org
Subject: [Question] io cgroup subsystem threaded support
Message-ID: <20211001110534.hfzjltilowrdpg4r@T580.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Posted to both cgroups and linux-block

Hi i read though some of the source code for cgroups, and from my understanding
the io cgroup subsystem does not support threaded cgroups. So i had some questions
regarding this.

 - Is there any future plans for supporting threaded?
 - What are the main hurdles in adding threaded support to the io cgroup subsystem?

Thanks,
Odin.
