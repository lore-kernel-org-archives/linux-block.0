Return-Path: <linux-block-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52650 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751385AbdAMWYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 17:24:09 -0500
Subject: Re: [PATCH] nbd: create a recv workqueue per nbd device
To: Josef Bacik <jbacik@fb.com>, linux-block@vger.kernel.org
References: <1484322673-10606-1-git-send-email-jbacik@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ef333dc1-64c6-ac46-5dd3-c62509e7dd89@grimberg.me>
Date: Sat, 14 Jan 2017 00:24:05 +0200
MIME-Version: 1.0
In-Reply-To: <1484322673-10606-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Josef,

> Since we are in the memory reclaim path we need our recv work to be on a
> workqueue that has WQ_MEM_RECLAIM set so we can avoid deadlocks.  Also
> set WQ_HIGHPRI since we are in the completion path for IO.

Really a workqueue per device?? Did this really give performance
advantage? Can this really scale with number of devices?
