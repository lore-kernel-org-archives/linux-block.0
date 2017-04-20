Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21887 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939867AbdDTCed (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 22:34:33 -0400
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Subject: Re: [PATCH 1/9] bio-integrity: Do not allocate integrity context for bio w/o data
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
        <1491332201-26926-2-git-send-email-dmonakhov@openvz.org>
Date: Wed, 19 Apr 2017 22:34:25 -0400
In-Reply-To: <1491332201-26926-2-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Tue, 4 Apr 2017 22:56:33 +0400")
Message-ID: <yq1pog7q026.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Dmitry Monakhov <dmonakhov@openvz.org> writes:

> If bio has no data, such as ones from blkdev_issue_flush(),
> then we have nothing to protect.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
