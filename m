Return-Path: <linux-scsi-owner@vger.kernel.org>
Date: Thu, 18 May 2017 06:19:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Omar Sandoval <osandov@osandov.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH blktests 0/3] Add SCSI generic test group
Message-ID: <20170518131928.GA26060@infradead.org>
References: <cover.1495109149.git.jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1495109149.git.jthumshirn@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

All SG_IO test should also apply to block device nodes that support
the ioctl..
