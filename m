Return-Path: <linux-fsdevel-owner@vger.kernel.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
        <1494429652-9488-4-git-send-email-dmonakhov@openvz.org>
Date: Wed, 10 May 2017 18:40:13 -0400
In-Reply-To: <1494429652-9488-4-git-send-email-dmonakhov@openvz.org> (Dmitry
        Monakhov's message of "Wed, 10 May 2017 19:20:46 +0400")
Message-ID: <yq1pofgmj3m.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>


Dmitry,

> SCSI drivers do care about bip_seed so we must update it accordingly.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
