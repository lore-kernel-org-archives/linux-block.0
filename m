Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Wed, 19 Apr 2017 22:37:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: convert unrecovered read error to -EILSEQ
Message-ID: <20170420053711.GA10381@infradead.org>
References: <1491221029-1609-1-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491221029-1609-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Looks like I won't get the major error status changes into 4.12,
so let's go with these patches for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
