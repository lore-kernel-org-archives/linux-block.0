Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
To: Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn <jthumshirn@suse.de>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
 <d60d4499-6ed8-0a69-edbf-db205a6dba6a@kernel.dk>
 <8b47ca34-d2ff-26dc-721e-2cb1e18f1efc@grimberg.me>
 <499af528-7810-f82d-1f11-cbf8f3a5b21c@grimberg.me>
Cc: linux-block@vger.kernel.org, Linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <keith.busch@intel.com>
Message-ID: <53a3fb6c-c75a-519a-f669-2bcab404e01d@grimberg.me>
Date: Tue, 17 Jan 2017 18:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <499af528-7810-f82d-1f11-cbf8f3a5b21c@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Oh, and the current code that was tested can be found at:

git://git.infradead.org/nvme.git nvme-irqpoll
