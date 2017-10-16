Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block: fix Sphinx kernel-doc warning
To: Randy Dunlap <rdunlap@infradead.org>, LKML
 <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
References: <a966c745-387b-f36a-8ed3-f613a56f88d2@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <18e64a4b-aed5-dba9-653d-4712cac27f72@kernel.dk>
Date: Mon, 16 Oct 2017 13:01:18 -0600
MIME-Version: 1.0
In-Reply-To: <a966c745-387b-f36a-8ed3-f613a56f88d2@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/16/2017 12:01 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Sphinx treats symbols that end with '_' as a kind of special
> documentation indicator, so fix that by adding an ending '*'
> to it.

Added for 4.15, thanks Randy.

-- 
Jens Axboe
