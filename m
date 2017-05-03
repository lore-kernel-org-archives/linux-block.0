Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: update ->init_request and ->exit_request prototypes
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
References: <20170427174501.18965-1-hch@lst.de> <20170428145300.GA1776@lst.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7aaf923d-4f7c-82f1-7bcc-80c435d59f93@grimberg.me>
Date: Wed, 3 May 2017 10:53:36 +0300
MIME-Version: 1.0
In-Reply-To: <20170428145300.GA1776@lst.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Turns out that while Jeff was right that this won't work against
> for-4.12/post-merge, it applies without fuzz and works fine against
> for-next.  Sorry for the confusion.

Regardless of that, series looks like a nice cleanup to me,
you can add to your respin:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
