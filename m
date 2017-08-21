Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:37140 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754341AbdHURZI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 13:25:08 -0400
Date: Mon, 21 Aug 2017 10:25:06 -0700 (PDT)
Message-Id: <20170821.102506.1119648270525550825.davem@davemloft.net>
To: bhumirks@gmail.com
Cc: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org,
        jbacik@fb.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
        manish.chopra@cavium.com, rahul.verma@cavium.com,
        Dept-GELinuxNICDev@cavium.com, harish.patil@cavium.com,
        cascardo@holoscopio.com, don@syst.com.br, dvhart@infradead.org,
        andy@infradead.org, sre@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd-general@lists.sourceforge.net, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/6] qlogic: make device_attribute const
From: David Miller <davem@davemloft.net>
In-Reply-To: <1503315792-14837-5-git-send-email-bhumirks@gmail.com>
References: <1503315792-14837-1-git-send-email-bhumirks@gmail.com>
        <1503315792-14837-5-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bhumika Goyal <bhumirks@gmail.com>
Date: Mon, 21 Aug 2017 17:13:10 +0530

> Make these const as they are only passed as an argument to the
> function device_create_file and device_remove_file and the corresponding
> arguments are of type const.
> Done using Coccinelle
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Applied.

But I would seriously suggest that when you have to cross subsystems
like this, just send the patches individually to the respective
maintainers rather than trying to make a "series" out of it.

Thanks.
